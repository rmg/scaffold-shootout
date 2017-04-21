# Scaffold Shootout

My experience with this sort of scaffolding is from using Rails a few years
ago and I wanted to see:
 1. how Rails has changed since I used it last
 2. what the "competition" was like these days

I muddled my way through setting up each app by skimming the docs I could
find, generally spending no more than 15-30 minutes on each, and not asking
anyone for help.

I didn't look super hard, but I was surprised by how few web frameworks
actually support Rails style scaffolding. In the end, I tested the following:

 * Rails 5.0.2
 * LoopBack 3.6.0
 * Phoenix 1.2.1
 * Sails 0.12.13
 * Kitura 1.6

The requirements were simple. To generate some sort of web app around the
following trivial models:

```
User:
  - name (string)
  - email (string)

Post:
  - title (text)
  - body (text)
  - author (User)

Comment:
  - body (text)
  - post (Post)
  - author (User)
```

That's it. I just want to see what gets done for me and how easy or painful
the generated code is as a jumping off point for building out a complete app.

Let's begin!

## Rails

Rails is where I started, so that's what I started with here.

 * 496d123 - rails new rails-blog
 * 2cc3525 - rails g scaffold User name:string email:string:uniq
 * 0b233de - rails g scaffold Post title:text body:text user:references
 * 4b71510 - rails g scaffold Comment body:text post:references user:references

The experience was basically exactly how I remembered it, except for models
becoming _slightly_ more magical. I don't really like models to have
properties that aren't documented as code in the model definition.

Ergonomics were decent, and other than the automagical model attributes, the
generated code looks relatively complete. The controllers show me where to
hang my code to override the various CRUD operations. There are trivial
templates in place for the different views, with a bonus of separate templates
for html and JSON.

I **love** the thorough documentation comments in the generated config files.

## LoopBack

I work at StrongLoop/IBM, so LoopBack was an obvious candidate. Disclaimer:
I'm one of the ones on the team who has never really touched LoopBack.

 * d5d839a - lb app (empty)
 * ed4f0a5 - lb model Author
 * 25a6737 - lb model Post
 * 89fc033 - lb model Comment
 * ca4c60a - lb relation (Post belongs to Author)
 * 0cb228a - lb relation (Comment belongs to Author)
 * 950bce4 - lb relation (Comment belongs to Post)

First off: ugh, I hate interactive CLIs. I want something scriptable, not a
text based wizard! There isn't really a sane way to document the options
chosen in the `lb` interview UI, so I've already forgotten what exactly I
selected.

I do recall being warned for each model that I didn't have any
datasources defined. I'm choosing to interpret that as evidence of LoopBack's
bias towards building APIs for existing databases instead of building
greenfield apps.

LoopBack (3.x) doesn't have a concept of controllers, so there are no
controllers generated. The focus is more on exposing the models via a REST-ish
API. As a side effect, there's really no "web app" as a result of the
scaffolding I generated. It _does_ have an explorer component that gives a
nice developer friendly interface to the models, but it's not really something
you can call a website.

There's a bunch of generate JSON config files (including the majority of the
model details), which I would have to dig through docs to figure out how to
modify. Actually, doing a quick scan via CLI shows that there is actually only
52 lines of actual JavaScript and 234 lines of JSON generated by all those
commands I ran. The real problem with scaffolding like this is that JSON
doesn't support comments, so I can't even submit a pull request to add
comments to the templates the generator uses.

## Phoenix

I've played with Phoenix a little while experimenting with Elixir. Elixir
feels like someone stole Ruby's wardrobe and played dress-up with Erlang and
discovered that a whole lot of it actually fits pretty darn well. Elixir was
written by an experienced Rails developer and Phoenix is a re-imagining of
Rails on top of Elixir. It is very well done.

 * 0fc813f - mix phoenix.new phoenix_blog
 * 07de996 - mix phoenix.gen.html User users name:string email:string
 * 7dc08e4 - phoenix_blog: manually add resource route
 * a2b22c8 - mix phoenix.gen.html Post posts title:string body:text
 * author:references:users
 * c603e41 - phoenix_blog: manually add /posts resource route
 * 5463926 - mix phoenix.gen.html Comment comments body:text
 * author:references:users post:references:posts
 * 3a762e4 - phoenix_blog: manually add /comments resource route

This scaffolding does _a lot_. The way Elixir/Erlang apps are distributed is
as standalone applications. As a result, this scaffolded app can actually be
packaged up as a self-contained tarball and deployed in almost any
environment.

The one weird bit is that I had to manually add routes for the resources that
I was able to generate by CLI. It was only one line per resource that I needed
to add, so it was relatively easy, but the instructions for doing it didn't
make it clear where in `web/router.ex` the lines were supposed to be added.
Assuming I picked the write place to put those route lines, Phoenix actually
produced what I consider the best scaffolding.

It solved my complaint about Rails having automagical model properties, so
that's cool. There are no handlers for JSON requests in this app like there
were for Rails, but that is almost certainly because I used `phoenix.gen.html`
instead of `phoenix.gen.json`.

Overall I'm quite pleased with this one.

## Sails

It rhymes with Rails, so I guess that means it is supposed to be a Rails
clone?

 * 694eb6c - sails generate new sails-blog
 * 3b47aa0 - sails generate model User name:string email:string
 * a78549e - sails generate controller User create show index update delete
 * b5b7416 - sails generate model Post title:string body:text
 * ee3d761 - sails generate controller Post create show index update delete
 * 9dc7b93 - sails generate model Comment body:text
 * 49435d9 - sails generate controller Comment create show index update delete
 * c3aa32f - sails: manually add relations to models

If it is a Rails clone it isn't a very good one. The website looks nice, and I
get the feeling that the Waterline ORM is where all the magic is at, but the
scaffolding doesn't really reflect that.

The first command generates a bunch of useful looking app-wide scaffolding
like error pages and various canned response types. Off to a great start!

The rest of the commands actually generated mostly empty files. Slightly more
useful than `touch api/models/$name.js`. Actually, if you're a whitespace
pedant like I am, the generator is actually _less_ useful than `touch` because
it produced a bunch of files without terminating newlines and _with_ lines
that contained only whitespace.

If it seems harsh to criticize the scaffolded code for whitespace problems
keep in mind that there wasn't actually much else generated to criticize.

I was feeling charitable at the end, so I spent a few minutes looking through
the docs to figure out how relations were defined. Turns out they're pretty
simple, so I added them manually.

## Swift

This one came across my desk because I had to add Swift support to our CI in
order to run the tests for `apic swiftserver`, which is basically a wrapper
for the `yo swiftserver` generator I tried out.

 * 21e837b - yo swiftserver
 * 9c7f29e - yo swiftserver:model User
 * c26b651 - yo swiftserver:model Post
 * e74e523 - yo swiftserver:model Comment

Nice and short. That is partially because it seems to have followed LoopBack's
pattern of a text-based wizard instead of a more script-friendly CLI.

I also encountered some compilation errors at the end of each command, but
I've dismissed them as likely something wrong with my environment. They didn't
seem to interfere with the code generation so I'm not giving any demerits for
that.

The most visible problem with the generated code is that I couldn't create the
inter-model relationships, similar to the problem I had with Sails. Unlike
Sails, however, for the life of me I couldn't figure out how to even do this
manually.

What I _do_ like about the generated Swift code is that I don't see a lot of
magic in the `Sources/Generated/*Resource.swift` files. Unfortunately, what I
see is a whole lot of code. I'm not sure if this is just boilerplate that one
has to live with in Swift/Kitura land, or if it is a feature of the generator.
I'm also a little nervous about the directory structure. Am I supposed to
modify the files under `Sources/Generated/`? Or is there some sort of workflow
for re-generating the files from something else?

# Conclusions

Ignoring my familiarity (or lack of familiarity) with the various languages,
or my ability to pester the LoopBack developers for help at any time, I'm
calling Phoenix the winner.

The scaffolded output looks to be the most useful and complete starting point
given the input, despite it having a couple manual steps.

# Suggestions For The Generator Authors

 * generated code should exemplify good code
   * comments directed at people new to the code
   * obvious places to extend functionality and hang custom code
 * interactive CLIs should not be the only option
 * it is way easier to extend scaffolded tests than to write from scratch
