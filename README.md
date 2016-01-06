# tldr.swift
A [tldr](http://tldr-pages.github.io/) client written in Swift using Swift 2.2 snapshots and the Swift Package Manager

![tldr cli screenshot](https://cloud.githubusercontent.com/assets/112204/12140410/03f8da98-b468-11e5-821c-3459ff8e1e96.png)

# Build

```sh
$ git clone https://github.com/johankj/tldr.swift/
$ cd tldr.swift
$ swift build
```

# Install
```sh
$ sudo cp .build/debug/tldr /usr/bin/local/tldr
```

# Usage
```sh
$ tldr -u
Successfully updated the cache.
$ tldr zip
```

# Requirements
Swift 2.2 and the Swift Package Manager.

You can download the most recent snapshot from [swift.org](https://swift.org/download/).
