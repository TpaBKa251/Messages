package ru.tpu.hostel.messages.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import java.time.LocalDateTime;
import java.util.UUID;

@Getter
@Setter
@Entity
@Table(name = "messages_meta", schema = "message")
public class MessageMeta {
    @Id
    @GeneratedValue
    @Column(name = "id", updatable = false, nullable = false)
    private UUID id;

    @Column(name = "title")
    private String title;

    @ManyToOne
    @JoinColumn(name = "broadcast_id", nullable = false)
    private Broadcast broadcast;

    @Column(name = "sender", nullable = false)
    private UUID sender;

    @Column(name = "scheduled_at", nullable = false)
    private LocalDateTime scheduledAt;
}
