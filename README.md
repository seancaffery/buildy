# Buildy

Easily track the build state of your branches.

Buildy allows you to track which builds are passing for all of your
branches, which gives you insight into which revisions of your software
are ready to ship.

It tracks the time taken to run all of the builds assoicated with a
branch, if they were run serially, and calculates the wall time taken to
completely build a revision. Giving insight into time saved by running
builds in parallel.

It also exposes a last good revision API which allows you to
automatically deploy your software as soon as it passed all of your
tests.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
