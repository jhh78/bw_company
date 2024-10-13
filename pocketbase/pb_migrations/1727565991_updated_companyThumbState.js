/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("p8dsjwo1k2usa8f")

  collection.options = {
    "query": "select id, comment.`refCompany`, AVG(comment.`thumbUp`)as thumbUp, AVG(comment.`thumbDown`) as thumbDown\nfrom comment\ngroup by comment.`refCompany`"
  }

  // remove
  collection.schema.removeField("g4kbe9qe")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "8rpvdvyv",
    "name": "refCompany",
    "type": "relation",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "collectionId": "gjdz4ct0k8xik52",
      "cascadeDelete": false,
      "minSelect": null,
      "maxSelect": 1,
      "displayFields": null
    }
  }))

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "wjcevsyt",
    "name": "thumbUp",
    "type": "json",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "maxSize": 1
    }
  }))

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "rottse71",
    "name": "thumbDown",
    "type": "json",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "maxSize": 1
    }
  }))

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("p8dsjwo1k2usa8f")

  collection.options = {
    "query": "select id, comment.`refCompany`\nfrom comment\ngroup by comment.`refCompany`"
  }

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "g4kbe9qe",
    "name": "refCompany",
    "type": "relation",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "collectionId": "gjdz4ct0k8xik52",
      "cascadeDelete": false,
      "minSelect": null,
      "maxSelect": 1,
      "displayFields": null
    }
  }))

  // remove
  collection.schema.removeField("8rpvdvyv")

  // remove
  collection.schema.removeField("wjcevsyt")

  // remove
  collection.schema.removeField("rottse71")

  return dao.saveCollection(collection)
})
