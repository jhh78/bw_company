/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("p8dsjwo1k2usa8f")

  collection.options = {
    "query": "select \n  company.id, \n  company.name, company.homepage, company.location,\n  sum(\n  case \n    when comment.`thumbUp` ISNULL then 0\n    else comment.`thumbUp` \n  end ) as thumbUp, \n  sum(\n  case \n    when comment.`thumbDown` ISNULL then 0\n    else comment.`thumbDown` \n  end ) as thumbDown\nfrom company left join comment on company.id = comment.`refCompany`\ngroup by company.id"
  }

  // remove
  collection.schema.removeField("uqxd8xng")

  // remove
  collection.schema.removeField("ggcw1xvg")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "fu4d3dyp",
    "name": "name",
    "type": "text",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "min": null,
      "max": null,
      "pattern": ""
    }
  }))

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "pemjgc6v",
    "name": "homepage",
    "type": "text",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "min": null,
      "max": null,
      "pattern": ""
    }
  }))

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "pr4bzal8",
    "name": "location",
    "type": "text",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "min": null,
      "max": null,
      "pattern": ""
    }
  }))

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "em9nmyzc",
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
    "id": "6ajn5juc",
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
    "query": "select \n  company.id, \n  sum(\n  case \n    when comment.`thumbUp` ISNULL then 0\n    else comment.`thumbUp` \n  end ) as thumbUp, \n  sum(\n  case \n    when comment.`thumbDown` ISNULL then 0\n    else comment.`thumbDown` \n  end ) as thumbDown\nfrom company left join comment on company.id = comment.`refCompany`\ngroup by company.id"
  }

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "uqxd8xng",
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
    "id": "ggcw1xvg",
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
  collection.schema.removeField("fu4d3dyp")

  // remove
  collection.schema.removeField("pemjgc6v")

  // remove
  collection.schema.removeField("pr4bzal8")

  // remove
  collection.schema.removeField("em9nmyzc")

  // remove
  collection.schema.removeField("6ajn5juc")

  return dao.saveCollection(collection)
})
