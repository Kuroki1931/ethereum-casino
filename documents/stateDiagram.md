```mermaid

stateDiagram
    PlayerHasABalance --> PlayerHasABalance: Player fund account
    PlayerHasABalance --> PlayerHasABalance: Player withdraw funds
    PlayerHasABalance --> Bet: Has enough funds?
    Bet --> Play: Calculate result
    Play --> PlayerHasABalance: Update player balance
    
```