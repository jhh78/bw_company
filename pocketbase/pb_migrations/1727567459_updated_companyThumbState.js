/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("p8dsjwo1k2usa8f")

  collection.options = {
    "query": "select \n  company.id, \n  sum(\n  case \n    when comment.`thumbUp` ISNULL then 0\n    else comment.`thumbUp` \n  end ) as thumbUp, \n  sum(\n  case \n    when comment.`thumbDown` ISNULL then 0\n    else comment.`thumbDown` \n  end ) as thumbDown\nfrom company left join comment on company.id = comment.`refCompany`\ngroup by company.id"
  }

  // remove
  collection.schema.removeField("tzlmpslx")

  // remove
  collection.schema.removeField("c0m3gqjo")

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

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("p8dsjwo1k2usa8f")

  collection.options = {
    "query": "select \n  company.id, \n  sum(\n  case \n    when comment.`thumbUp` ISNULL then 0\n    else comment.`thumbUp` \n  end ) as aa, \n  sum(comment.`thumbUp`) as bb\nfrom company left join comment on company.id = comment.`refCompany`\ngroup by company.id"
  }

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "tzlmpslx",
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
    "id": "c0m3gqjo",
    "name": "bb",
    "type": "json",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "maxSize": 1
    }
  }))

  // remove
  collection.schema.removeField("uqxd8xng")

  // remove
  collection.schema.removeField("ggcw1xvg")

  return dao.saveCollection(collection)
})
