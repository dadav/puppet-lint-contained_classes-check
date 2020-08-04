puppet-contained-classes-check
=================================

A puppet-lint plugin to check that you contain your ressource-like created classes.


## Checks

### Class containment

If you don't contain the classes, they will run out of order and mess with your profiles.

#### What you have done

```puppet
class { 'apache':
  ensure => present,
}
```

#### What you should have done

```puppet
class { 'apache':
  ensure => present,
}
contain apache
```

#### Disabling the check

To disable this check, you can add `--no-contained-classes-check` to your puppet-lint command line.

```shell
$ puppet-lint --no-contained_classes-check path/to/file.pp
```

Alternatively, if you’re calling puppet-lint via the Rake task, you should insert the following line to your `Rakefile`.

```ruby
PuppetLint.configuration.send('disable_contained_classes')
```
