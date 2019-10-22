# Intercom's Test

### Requirements
- Ruby 2.6.2
- Bundler installed for that version (`gem install bundler`)

### Usage
`bundle install`

I've built the task as a trivial CLI app application. See more options `bin/runner --help`

To get started quickly 

```
curl -O https://s3.amazonaws.com/intercom-take-home-test/customers.txt | bin/runner -l customers.txt
```

The CLI expects a text file to passed with the `l` flag

It works with any relative path.

### Architecture
There are 3 main files and a `bin` file to kickstart the process

`App` represents the main logic that is responsible for filtering and returning the customers given the Dublin office location and a max distance.
`Customer` is a wrapper around each line of the text file. It is also the parser of the file given that practically the `Customer` responsibilities are nothing more than a `Struct`
`Location` is the distance calculator between different locations. It works with any type of locations although we are always feeding it the Dublin office.


### Limitations
The input is very much restricted to a txt file. An improvement maybe it would be to receive an IO object instead
