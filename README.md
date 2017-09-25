# Miner

**TODO: Add description**
Design:
A master spawns 1000 slave processes
Each slave process mines coins independent of any other slave process
When a slave finds a coin, it send it to the master
Master checks if the coin has been discovered before. If not, it prints it

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `project1` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:project1, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/project1](https://hexdocs.pm/project1).

