package ru.tpu.hostel.messages.entity;

import jakarta.persistence.Column;
import lombok.Data;
import java.io.Serializable;
import java.util.UUID;

@Data
public class SubscriptionId implements Serializable {
    @Column(name = "user_id")
    private UUID userId;

    @Column(name = "broadcast_id")
    private UUID broadcastId;
}
