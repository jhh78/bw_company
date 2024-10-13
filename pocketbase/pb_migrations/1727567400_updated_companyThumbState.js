/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("p8dsjwo1k2usa8f")

  collection.options = {
    "query": "select \n  company.id, \n  sum(\n  case \n    when comment.`thumbUp` == null then 0\n    else comment.`thumbUp` \n  end ) as aa, \n  sum(comment.`thumbUp`) as bb\nfrom company left join comment on company.id = comment.`refCompany`\ngroup by company.id"
  }

  // remove
  collection.schema.removeField("cwecpmx6")

  // remove
  collection.schema.removeField("h3hbf7f6")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "nppsokr5",
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
    "id": "oytpxcbd",
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
    "query": "select company.id, sum(comment.`thumbDown`) as aa, sum(comment.`thumbUp`) as bb\nfrom company left join comment on company.id = comment.`refCompany`\ngroup by company.id"
  }

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

  // remove
  collection.schema.removeField("nppsokr5")

  // remove
  collection.schema.removeField("oytpxcbd")

  return dao.saveCollection(collection)
})
