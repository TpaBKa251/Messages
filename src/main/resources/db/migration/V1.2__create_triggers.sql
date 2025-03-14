-- Триггер на добавлеине --

CREATE OR REPLACE FUNCTION check_message_part_order()
    RETURNS TRIGGER AS $$
DECLARE
    max_part INTEGER;
BEGIN
    -- Находим максимальный номер части для данного сообщения
    SELECT COALESCE(MAX(message_part), 0)
    INTO max_part
    FROM message_contents
    WHERE message_id = NEW.message_id;

    -- Проверяем, что добавляемая часть является следующей по порядку
    IF NEW.message_part <> max_part + 1 THEN
        RAISE EXCEPTION 'Ошибка: части сообщения должны быть последовательными без пропусков. Ожидалась часть %, но добавлена часть %', max_part + 1, NEW.message_part;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER message_part_order_trigger
    BEFORE INSERT ON message_contents
    FOR EACH ROW
EXECUTE FUNCTION check_message_part_order();

-- Триггер на удаление --

CREATE OR REPLACE FUNCTION prevent_hole_deletion()
    RETURNS TRIGGER AS $$
DECLARE
    next_part_exists BOOLEAN;
BEGIN
    -- Проверяем, существует ли следующая часть сообщения
    SELECT EXISTS (
        SELECT 1 FROM message_contents
        WHERE message_id = OLD.message_id AND message_part = OLD.message_part + 1
    ) INTO next_part_exists;

    -- Если следующая часть существует, выбрасываем исключение
    IF next_part_exists THEN
        RAISE EXCEPTION 'Ошибка: нельзя удалять промежуточные части сообщения';
    END IF;

    -- Если следующей части нет, разрешаем удаление
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER prevent_gaps_on_delete
    BEFORE DELETE ON message_contents
    FOR EACH ROW
EXECUTE FUNCTION prevent_hole_deletion();