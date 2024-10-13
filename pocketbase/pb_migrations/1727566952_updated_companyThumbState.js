/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("p8dsjwo1k2usa8f")

  collection.options = {
    "query": "select company.id, comment.`thumbDown`, comment.`thumbUp`\nfrom company left join comment on company.id = comment.`refCompany`"
  }

  // remove
  collection.schema.removeField("nwosa2a5")

  // remove
  collection.schema.removeField("ky53juki")

  // remove
  collection.schema.removeField("vuzbxazl")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "bwsawpr7",
    "name": "thumbDown",
    "type": "number",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "min": null,
      "max": null,
      "noDecimal": false
    }
  }))

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "l1jntepu",
    "name": "thumbUp",
    "type": "number",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "min": null,
      "max": null,
      "noDecimal": false
    }
  }))

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("p8dsjwo1k2usa8f")

  collection.options = {
    "query": "select id, comment.`refCompany`, SUM(comment.`thumbUp`)as thumbUp, SUM(comment.`thumbDown`) as thumbDown\nfrom comment\ngroup by comment.`refCompany`"
  }

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "nwosa2a5",
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
    "id": "ky53juki",
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
    "id": "vuzbxazl",
    "name": "thumbDown",
    "type": "json",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "maxSize": 1
    }
  }))

  // remove
  collection.schema.removeField("bwsawpr7")

  // remove
  collection.schema.removeField("l1jntepu")

  return dao.saveCollection(collection)
})
