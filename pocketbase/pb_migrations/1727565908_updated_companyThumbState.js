/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("p8dsjwo1k2usa8f")

  collection.options = {
    "query": "select id, comment.`refCompany`\nfrom comment\ngroup by comment.`refCompany`"
  }

  // remove
  collection.schema.removeField("hj57wwqe")

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

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("p8dsjwo1k2usa8f")

  collection.options = {
    "query": "select id, comment.`refCompany`\nfrom comment"
  }

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "hj57wwqe",
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
  collection.schema.removeField("g4kbe9qe")

  return dao.saveCollection(collection)
})
