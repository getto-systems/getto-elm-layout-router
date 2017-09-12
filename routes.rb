require "getto/elm/layout/router"

router = Getto::Elm::Layout::Router::Drawer.new(
  File.expand_path("../routes.json",__FILE__),
  app: {
    port: 1000,
    project: "getto/habit",
    company: "GETTO",
    title: "Habit",
    sub: "logging works",
  },
  version: {
    css: "0.0.3",
    app: "0.0.1",
  },
  package: {
    "page": "GettoHabit",
    "i18n": "GettoHabit",
  },
)

router.draw do
  namespace :demo do
    page :demo1, "demo1"
    page :demo2, "demo2", version: {css: "0.1.4"}
    page :demo3, "demo3", package: {page: "GettoLayout"}
  end
end
