package ru.tpu.hostel.messages.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import java.time.LocalDateTime;
import java.util.UUID;

@Getter
@Setter
@Entity
@Table(name = "subscriptions")
public class Subscription {
    @EmbeddedId
    private SubscriptionId id;

    @Column(name = "user_id", nullable = false)
    private UUID user;

    @Column(name = "broadcast_id", nullable = false)
    private UUID broadcast;

    @Column(name = "started_at", nullable = false)
    private LocalDateTime startedAt;
}
