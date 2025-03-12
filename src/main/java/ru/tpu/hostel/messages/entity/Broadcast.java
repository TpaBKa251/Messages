package ru.tpu.hostel.messages.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.UUID;

@Getter
@Setter
@Entity
@Table(name = "broadcasts", schema = "message")
public class Broadcast {
    @Id
    @GeneratedValue
    @Column(name = "id", updatable = false, nullable = false)
    private UUID id;

    @Column(name = "theme", nullable = false)
    private String theme;

    @Column(name = "created_at")
    private LocalDateTime createdAt;
}
