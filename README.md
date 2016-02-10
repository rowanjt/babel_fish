BabelFish
=========

BableFish is a ruby library which provides an interface for locale translations of dynamic, user entered, data.

The goal is to provide better performing read/write acess to a relational data store (initially postgresql). The library adds a level of abstraction on top of the different approaches to storing frequently changing translations (ie. associated table, json, hstore, text, etc.).

Another intention is to keep this decoupled from the persistant layer of an aplication. Therefore it is the responsibility of the calling application to implement...

add_column :question, :texts, :hstore

serialize :texts, ActiveRecord::Coders::Hstore
