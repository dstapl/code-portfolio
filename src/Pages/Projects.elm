module Pages.Projects exposing (Project, projects)


type alias Project =
    { title : String
    , language : String
    , description : String
    , context : String
    , source : Maybe String
    }


githubRepo : String -> Maybe String
githubRepo name =
    Just ("https://github.com/dstapl/" ++ name)

projects : List Project
projects =
    [ { title = "Direct N-body Simulator"
      , language = "Fortran"
      , description =
            "A gravitational direct N-body simulator, constrained to CPU processing. Taking advantage of SIMD, OpenMP multi-threading, and algorithm optimisations."
      , context = "MSc Astrophysics Dissertation"
      , source = githubRepo "NBODY"
      }
    , { title = "CV Classification"
      , language = "Python · R"
      , description =
            "Astronomical photometry and the detection of superhump periodicities in Cataclysmic Variable stars."
      , context = "BSc Research Project"
      , source = githubRepo "CV-Classification"
      }
    , { title = "SIMBAD Object Finder"
      , language = "Julia"
      , description =
            "An interactive astronomical object filtering tool built using Pluto.jl. Built to aid first-year telescope observations."
      , context = "Personal Project"
      , source = githubRepo "SIMBAD-object-finder"
      }
    , { title = "Neovim Configuration"
      , language = "Lua"
      , description =
            ""
      , context = "Config files"
      , source = githubRepo "nvimrc"
      }
    ]
