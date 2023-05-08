# Mastering OTP/Concurrency Framework in Elixir

Building a Key-Value Store From The Official Elixir Docs.

## Topics Covered

1. Processes
2. Macros
3. Quote & Unquote
4. Agents
5. Genservers
6. Supervisor
7. Application
8. Dynamic Supervisors
9. ETS
10. Umbrella Projects
11. Tasks
12. Testing

## Design

```elixir

        # Registry -> PID(0.100.0)
        {  
            %{ # Names
                "shopping" => PID(0.200.0)
            },
            %{  # Refs
                REF1234: "shopping" 
            }
        }

        # Bucket -> PID(0.200.0)
        # Ref -> 1234
        %{
            "milk" => 1,
            "eggs" => 2
        }
```