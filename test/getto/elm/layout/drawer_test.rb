require "test_helper"

class Getto::Elm::Layout::DrawerTest < Minitest::Test
  def test_deep_merge
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
        css: "0.1.3",
        app: "0.0.1",
      },
      package: {
        "page": "GettoHabit",
        "i18n": "GettoHabit",
      },
    )

    config = router.build do
      namespace :demo do
        page :demo1, "demo1"
        page :demo2, "demo2", version: {css: "0.1.2"}
      end
      namespace :demo_demo, package: {page: "GettoLayout"} do
        page :demo_demo3, "demo3"
        page :demo_demo4, "demo4"
      end
    end

    assert_equal(
      {
        "demo/demo1" => {
          app: {
            port: 1000,
            project: "getto/habit",
            company: "GETTO",
            title: "Habit",
            sub: "logging works",
          },
          version: {
            css: "0.1.3",
            app: "0.0.1",
          },
          package: {
            "page": "GettoHabit",
            "i18n": "GettoHabit",
          },
          title: "demo1",
          module: "Demo.Demo1",
        },
        "demo/demo2" => {
          app: {
            port: 1000,
            project: "getto/habit",
            company: "GETTO",
            title: "Habit",
            sub: "logging works",
          },
          version: {
            css: "0.1.2",
            app: "0.0.1",
          },
          package: {
            "page": "GettoHabit",
            "i18n": "GettoHabit",
          },
          title: "demo2",
          module: "Demo.Demo2",
        },
        "demo_demo/demo_demo3" => {
          app: {
            port: 1000,
            project: "getto/habit",
            company: "GETTO",
            title: "Habit",
            sub: "logging works",
          },
          version: {
            css: "0.1.3",
            app: "0.0.1",
          },
          package: {
            "page": "GettoLayout",
            "i18n": "GettoHabit",
          },
          title: "demo3",
          module: "DemoDemo.DemoDemo3",
        },
        "demo_demo/demo_demo4" => {
          app: {
            port: 1000,
            project: "getto/habit",
            company: "GETTO",
            title: "Habit",
            sub: "logging works",
          },
          version: {
            css: "0.1.3",
            app: "0.0.1",
          },
          package: {
            "page": "GettoLayout",
            "i18n": "GettoHabit",
          },
          title: "demo4",
          module: "DemoDemo.DemoDemo4",
        },
      },
      config,
      "build"
    )
  end
end
