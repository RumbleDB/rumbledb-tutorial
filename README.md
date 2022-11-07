# RumbleDB tutorial - Declarative Amsterdam 2022

## Update: the links used in the slides


Release page with the jar: [https://github.com/RumbleDB/rumble/releases](https://github.com/RumbleDB/rumble/releases)

Pattern of pre-stored query solutions: [http://www.rumbledb.org/samples/1.jq](http://www.rumbledb.org/samples/1.jq)

Small dataset: [https://www.rumbledb.org/samples/git-archive.json](https://www.rumbledb.org/samples/git-archive.json)

Larger dataset: [https://www.rumbledb.org/samples/git-archive-big.json](https://www.rumbledb.org/samples/git-archive-big.json)

Huger dataset: [https://data.gharchive.org/2022-11-01-0.json.gz](https://data.gharchive.org/2022-11-01-0.json.gz)

Great language game: [https://lars.yencken.org/datasets/great-language-game/](https://lars.yencken.org/datasets/great-language-game/)

## What is RumbleDB?

RumbleDB is an engine that allows you to query large, messy datasets with JSONiq.

It works on your laptop, smartly spreading computations on all your cores (by encapsulating Apache Spark in a way that is hidden from the user), but also works on a large cluster of machines (3, or 5, or 10, or 50, or 100, or 1000...) in the cloud.

On your laptop, it works with very small files in kB, all the way to 100s of GBs.
On a cluster, it works with very small files in kB, all the way to 100s of TBs.

It supports JSON, CSV, Parquet, Avro, ...

In this tutorial, we will simply work with your laptop.

## Installation notes

RumbleDB can be installed in four different ways:
- As a standalone Java jar that contains all it needs (for use on a laptop)
- As a thin jar for use with an existing Apache Spark installation (for use on a laptop or a cluster)
- As a docker image (for use on a laptop)
- As a brew recipe (for use on a laptop running macOS)

For this tutorial, we will use the standalone Java jar, because this is the most straightforward way to get started.

## Installing Java

First, you need to install Java. We will use Java 11.

### macOS

On macOS, we recommend using the Adoptium distribution, which has an Apache 2.0 license. The Adoptium distribution can be installed from [this page](https://adoptium.net/en-GB/temurin/releases/?version=11). You need to download the .pkg version that corresponds to macOS and your type of CPU. For this you can use the filtering dropdowns by selecting "macOS" as the operating system, either x64 (for Intel-based Macs) or aarch64 (for the newer M1 or M2 Macs) as the architecture, "JDK" as the package type, and "11" as the version.

Once you have finished the installation, you can check that the correct version of Java is running:

    java -version
   
which should display something like this (what is important is the 11, and not 8 or 17):

    openjdk version "11.0.16.1" 2022-08-12
    OpenJDK Runtime Environment Temurin-11.0.16.1+1 (build 11.0.16.1+1)
    OpenJDK 64-Bit Server VM Temurin-11.0.16.1+1 (build 11.0.16.1+1, mixed mode)

In case a different version is displayed, you need to point JAVA_HOME to the right directory. For macOS, you can run:

    export JAVA_HOME=`/usr/libexec/java_home -v 11` 

And then run

    java -version
    
again to check that this worked.

### Ubuntu

In ubuntu, you can use the package manager like so:

    sudo apt install openjdk-11-jdk
    
Then set JAVA_HOME with:

    export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
    
And then run

    java -version
    
again to check that this worked (it should say 11, not 8 or 17).

### Windows

On Windows, we recommend using the Adoptium distribution, which has an Apache 2.0 license. The Adoptium distribution can be installed from [this page](https://adoptium.net/en-GB/temurin/releases/?version=11). You need to download the .msi file for Windows (x64). For this you can use the filtering dropdowns by selecting "Windows" as the operating system, x64 as the architecture (except if you have a very old laptop running in 32-bit mode), "JDK" as the package type, and "11" as the version.

Simply run the installer and make sure to activate the setup of the PATH and JAVA_HOME directories

Once you have finished the installation, you can check that the correct version of Java is running by running in a command window:

    java -version
   
which should display something like this (what is important is the 11, and not 8 or 17):

    openjdk version "11.0.16.1" 2022-08-12
    OpenJDK Runtime Environment Temurin-11.0.16.1+1 (build 11.0.16.1+1)
    OpenJDK 64-Bit Server VM Temurin-11.0.16.1+1 (build 11.0.16.1+1, mixed mode)
    
again to check that this worked.

## Download the RumbleDB jar (all systems)

The RumbleDB jar can directly be downloaded from [this place](https://github.com/RumbleDB/rumble/releases/download/v1.19.0/rumbledb-1.19.0-standalone.jar).

Just put it in a directory of your choice, specially created for the tutorial. In this directory, we will also put datasets and a jupyter notebook.

## Checking that the RumbleDB jar gets correctly executed (all systems)

To check that it works, open a command window, go to the directory, and try to run the following command:

    java -jar rumbledb-1.19.0-standalone.jar
    
which should do nothing else than display get-started instructions:

        ____                  __    __     ____  ____ 
       / __ \__  ______ ___  / /_  / /__  / __ \/ __ )
      / /_/ / / / / __ `__ \/ __ \/ / _ \/ / / / __  |  The distributed JSONiq engine
     / _, _/ /_/ / / / / / / /_/ / /  __/ /_/ / /_/ /   1.19.0 "Tipuana Tipu" beta
    /_/ |_|\__,_/_/ /_/ /_/_.___/_/\___/_____/_____/  
    
    
    
    RumbleDB is a JSONiq engine that can be used both on your laptop or on a
    cluster (e.g. with Amazon EMR or Azure HDInsight).
    
    This is the standalone jar that does not require the installation of Spark.
    
    If you need more control over Spark or use it on a cluster, we recommend using
    the leaner jars instead, which you can download from www.rumbledb.org.
    
    If you do not want to install Spark, then you need to use the standalone jar
    instead from www.rumbledb.org.
    
    Usage:
    jar -jar <path to RumbleDB's jar> <mode> <parameters>
    
    The first optional argument specifies the mode:
    **** run ****
    for directly running a query from an input file or (with -q) provided directly on the command line.
    
    It is the default mode.
    
    jar -jar rumbledb-1.19.0.jar run my-query.jq
    jar -jar rumbledb-1.19.0.jar run -q '1+1'

    You can specify an output path with -o like so:
    jar -jar rumbledb-1.19.0.jar run -q '1+1' -o my-output.txt
    
    **** serve ****
    for running as an HTTP server listening on the specified port (-p) and host (-h).
    
    jar -jar rumbledb-1.19.0.jar serve -p 9090
    
    RumbleDB also supports Apache Livy for use in Jupyter notebooks, which may be
    even more convenient if you are using a cluster.
    
    **** repl ****
    for shell mode.
    
    spark-submit rumbledb-1.19.0.jar repl
    
    
    **** resource use configuration ****
    
    For a local use, you can control the number of cores, as well as allocated
    memory, with:
    
    java -jar -Xmx10g rumbledb-1.19.0.jar repl
    
    More documentation on available CLI parameters is available on https://www.rumbledb.org/

    
## Run a hello-world query (all systems)

You can check that the 1+1 query works with:

    java -jar rumbledb-1.19.0-standalone.jar run -q '1+1'
    
This should return (possibly with some additional info or warning messages that you can safely ignore) 2, as expected.

Next, you can check that the embedded Apache Spark works correctly with this query:

    java -jar rumbledb-1.19.0-standalone.jar run -q 'for $i in parallelize(1 to 100, 10) return { "foo" : $i }'

This should return a sequence of 100 objects, looking like this (also possibly with some additional info or warning messages that you can safely ignore):

    { "foo" : 1 }
    { "foo" : 2 }
    { "foo" : 3 }
    { "foo" : 4 }
    { "foo" : 5 }
    { "foo" : 6 }
    { "foo" : 7 }
    { "foo" : 8 }
    ...

Next, you can check that RumbleDB manages to read files from the Web:

    java -jar rumbledb-1.19.0-standalone.jar run -q 'json-file("https://www.rumbledb.org/download/movies.jsonl")[1]'
    
Showing:

    { "genres" : "Thriller", "actors" : [ { "birth" : "1920", "name" : "Mickey Rooney", "death" : "2014" }, { "birth" : "1916", "name" : "Keenan Wynn", "death" : "1986" } ], "name" : "The Manipulator", "year" : "1971", "votes" : "248", "rating" : "3.8" }

And finally, you can download the actual dataset from [this place](https://www.rumbledb.org/download/movies.jsonl) to your directory (the same where you have the RumbleDB jar) and execute

    java -jar rumbledb-1.19.0-standalone.jar run -q 'json-file("movies.jsonl")[1]'
    
Showing:

    { "genres" : "Thriller", "actors" : [ { "birth" : "1920", "name" : "Mickey Rooney", "death" : "2014" }, { "birth" : "1916", "name" : "Keenan Wynn", "death" : "1986" } ], "name" : "The Manipulator", "year" : "1971", "votes" : "248", "rating" : "3.8" }

