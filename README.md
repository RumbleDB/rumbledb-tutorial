# RumbleDB tutorial

## What is RumbleDB?

RumbleDB

## Installation notes

RumbleDB can be installed in four different ways:
- As a standalone Java jar that contains all it needs (for use on a laptop)
- As a thin jar for use with an existing Apache Spark installation (for use on a laptop or a cluster)
- As a docker image (for use on a laptop)
- As a brew recipe (for use on a laptop running macOS)

For this tutorial, we will use the standalone Java jar, because this is the most straightforward way to get started.

## Java

First, you need to install Java. We will use Java 11.

We recommend using the Adoptium distribution, which has an Apache 2.0 license. The Adoptium distribution can be installed from [this page](https://adoptium.net/en-GB/temurin/releases/?version=11). You need to download the version that corresponds to your operating system.

Once you have finished the installation, you can check that the correct version of Java is running:

    java -version
   
which should display something like this (what is important is the 11, and not 8 or 17):

    openjdk version "11.0.16.1" 2022-08-12
    OpenJDK Runtime Environment Temurin-11.0.16.1+1 (build 11.0.16.1+1)
    OpenJDK 64-Bit Server VM Temurin-11.0.16.1+1 (build 11.0.16.1+1, mixed mode)

In case a different version is displayed, you need to point JAVA_HOME to the right directory. For macOS, you can run:

    export JAVA_HOME=`/usr/libexec/java_home -v 11` 
