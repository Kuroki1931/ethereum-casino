```mermaid
sequenceDiagram
    actor User
    participant Bank
    User->>Bank:withdraw()
    activate Bank
    deactivate Bank
    Bank->>User:result
```