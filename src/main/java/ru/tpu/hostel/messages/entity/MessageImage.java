package ru.tpu.hostel.messages.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import java.util.UUID;

@Getter
@Setter
@Entity
@Table(name = "message_images")
public class MessageImage {
    @Id
    @GeneratedValue
    @Column(name = "id", updatable = false, nullable = false)
    private UUID id;

    @ManyToOne
    @JoinColumn(name = "message_id", nullable = false)
    private MessageMeta message;

    @Column(name = "image_url", nullable = false)
    private String imageUrl;
}
