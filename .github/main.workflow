workflow "Jekyll build and deploy" {
  resolves = [
    "Jekyll Action",
  ]
  on = "push"
}

action "Jekyll Action" {
  uses = "hasalex/jekyll-action@master"
  needs = "Filters for Github Actions"
  secrets = ["JEKYLL_PAT"]
}

action "Filters for Github Actions" {
  uses = "actions/bin/filter@master"
  args = "branch develop"
}
