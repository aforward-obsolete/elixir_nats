# NATS - Elixir Client

A [Elixir](http://elixir-lang.org/) client for the [NATS messaging system](https://nats.io).

[![License MIT](https://img.shields.io/npm/l/express.svg)](http://opensource.org/licenses/MIT)

THIS PROJECT HAS NO FUNCTIONALITY YET, NOT READY FOR ANY SORT OF USE YET

Here is an example configuration to connect to your NATS server.

```elixir
# In your config/config.exs file
config :nats, Nats.Connection,
  url: "mynatsserver.com",
  port: 4222,
  verbose: true,
  pedantic: false,
  user: "aforward",
  password: "nicetry"
```

To integrate into your project, add to your ```mix.exs``` file:

```elixir
defp deps do
  [{:elixir_nats, "~> 0.1"}]
end
```

## License

(The MIT License)

Copyright (c) 2010-2015 Derek Collison

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to
deal in the Software without restriction, including without limitation the
rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
sell copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
IN THE SOFTWARE.
