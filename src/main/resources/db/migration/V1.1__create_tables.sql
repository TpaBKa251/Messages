CREATE TABLE "broadcasts" (
    "id" UUID NOT NULL PRIMARY KEY,
    "theme" text NOT NULL DEFAULT 'Без темы',
    "created_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE "subscriptions" (
     "id" UUID NOT NULL PRIMARY KEY,
     "user_id" UUID NOT NULL,
     "broadcast_id" UUID NOT NULL REFERENCES broadcasts(id),
     "started_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
     UNIQUE ("user_id", "broadcast_id")
);


CREATE TYPE status AS ENUM('draft', 'scheduled', 'sent', 'canceled', 'partly_sent');


CREATE TABLE messages_meta (
    "id" UUID NOT NULL PRIMARY KEY,
    "title" text,
    "broadcast_id" UUID NOT NULL REFERENCES broadcasts(id),
    "sender" UUID NOT NULL,
    "created_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "sent_at" TIMESTAMP DEFAULT NULL,
    "scheduled_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    "status" status DEFAULT 'draft'
);


CREATE TABLE "message_contents" (
    "id" UUID NOT NULL PRIMARY KEY,
    "message_id" UUID NOT NULL REFERENCES messages_meta("id"),
    "message_part" integer NOT NULL,
    "content" text NOT NULL,
    UNIQUE (message_id, message_part)
);


CREATE TABLE "message_images" (
    "id" UUID NOT NULL PRIMARY KEY,
    "message_id" UUID NOT NULL REFERENCES messages_meta("id"),
    "image_url" text NOT NULL
);


CREATE TABLE message_delivery (
      id UUID PRIMARY KEY,
      user_id UUID NOT NULL,
      message_id UUID NOT NULL REFERENCES messages_meta(id),
      sent_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
      read_at TIMESTAMP,
      UNIQUE (user_id, message_id)
);