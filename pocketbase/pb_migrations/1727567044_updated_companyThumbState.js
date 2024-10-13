/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("p8dsjwo1k2usa8f")

  collection.options = {
    "query": "select company.id, sum(comment.`thumbDown`) as aa, sum(comment.`thumbUp`) as bb\nfrom company left join comment on company.id = comment.`refCompany`\ngroup by company.id"
  }

  // remove
  collection.schema.removeField("bwsawpr7")

  // remove
  collection.schema.removeField("l1jntepu")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "cwecpmx6",
    "name": "aa",
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
    "id": "h3hbf7f6",
    "name": "bb",
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
    "query": "select company.id, comment.`thumbDown`, comment.`thumbUp`\nfrom company left join comment on company.id = comment.`refCompany`"
  }

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

  // remove
  collection.schema.removeField("cwecpmx6")

  // remove
  collection.schema.removeField("h3hbf7f6")

  return dao.saveCollection(collection)
})
