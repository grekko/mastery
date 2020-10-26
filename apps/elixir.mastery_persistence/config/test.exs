use Mix.Config

config :mastery_persistence,
       MasteryPersistence.Repo,
       database: "mastery_dev",
       hostname: "localhost",
       pool: Ecto.Adapters.SQL.Sandbox
