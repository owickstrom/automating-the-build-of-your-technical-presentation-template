---
title: Title of Your Talk
subtitle: Subtitle of Your Talk
author: Your Full Name
date: September 2017, Location
colorlinks: true
linkcolor: black
classoption:
- dvipsnames
---

## Introduction

- Something
- Another thing
- The last one

\notelist {
  \item I have stuff to say.
  \item This is a list.
  \item And I like it.
}

# Section One

## I Can LaTeX

\centerline{\Large{\textit{I can embed \LaTeX as well.}}}

<div class="notes">
And I can writes notes here in HTML.
</div>

# Section Two

## A Complete File

``` {.c include=src/listings/hello.c}
```

## Just A Snippet

``` {.c include=src/listings/hello.h snippet=the-good-part dedent=4}
```

# Section Three

## A Graphviz Diagram

![](../diagrams/door.png)

## A PlantUML Diagram

![](../uml/activity.png){width=70%}
