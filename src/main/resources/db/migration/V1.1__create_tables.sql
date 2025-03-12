CREATE TABLE "broadcasts" (
    "id" UUID NOT NULL UNIQUE,
    "theme" TEXT NOT NULL,
    "created_at" TIMESTAMP,
    PRIMARY KEY("id")
);


CREATE TABLE messages_meta (
    "id" UUID NOT NULL UNIQUE,
    "title" TEXT,
    "broadcast_id" UUID NOT NULL REFERENCES broadcasts(id),
    "sender" UUID NOT NULL,
    "scheduled_at" TIMESTAMP NOT NULL,
    PRIMARY KEY("id")
);


CREATE TABLE "subscriptions" (
    "user_id" UUID NOT NULL,
    "broadcast_id" UUID NOT NULL REFERENCES broadcasts(id),
    "started_at" TIMESTAMP NOT NULL,
    PRIMARY KEY("user_id", "broadcast_id")
);


CREATE TABLE "message_contents" (
    "id" UUID NOT NULL UNIQUE,
    "message_id" UUID NOT NULL REFERENCES messages_meta("id"),
    "message_part" INTEGER NOT NULL,
    "content" TEXT NOT NULL,
    PRIMARY KEY("id")
);


CREATE TABLE "message_images" (
    "id" UUID NOT NULL UNIQUE,
    "message_id" UUID NOT NULL REFERENCES messages_meta("id"),
    "image_url" TEXT NOT NULL,
    PRIMARY KEY("id")
);