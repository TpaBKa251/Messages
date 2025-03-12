package ru.tpu.hostel.messages.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import java.util.UUID;

@Getter
@Setter
@Entity
@Table(name = "message_contents", schema = "message")
public class MessageContent {
    @Id
    @GeneratedValue
    @Column(name = "id", updatable = false, nullable = false)
    private UUID id;

    @ManyToOne
    @JoinColumn(name = "message_id", nullable = false)
    private MessageMeta message;

    @Column(name = "message_part", nullable = false)
    private Integer messagePart;

    @Column(name = "content", nullable = false)
    private String content;

}
