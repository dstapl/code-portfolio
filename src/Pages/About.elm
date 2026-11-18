module Pages.About exposing (About, about)


type alias About =
    { name : String
    , subtitle : String
    , paragraphs : List String
    }

about : About
about =
    { name = "Daniel Stapleton"
    , subtitle = "MSc Astrophysics · Computing"
    , paragraphs =
        [ """I hold an MSc in Astrophysics, where my dissertation focused on optimising numerical simulations.
        Having used Linux since childhood, starting with Linux Mint, I've always enjoyed customising software and understanding systems from the ground up.
        This eventually led me to build a minimal Gentoo install during my MSc, optimising my laptop setup for performance."""

        , """I started with Python for automation, later found Julia for mathematical visualisation, and taught myself Rust (pre-AI) to explore compiled, systems-level programming.
        Working across these different ecosystems has made me quick to pick up new languages through documentation and hands-on experimentation."""
        ]
    }
