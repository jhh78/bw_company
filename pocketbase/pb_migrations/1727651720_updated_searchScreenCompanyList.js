/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("nfh6oodiwpl747s")

  collection.options = {
    "query": "select \n  company.id, \n  company.name, company.homepage, company.location,\n  sum(\n  case \n    when comment.`thumbUp` ISNULL then 0\n    else comment.`thumbUp` \n  end ) as thumbUp, \n  sum(\n  case \n    when comment.`thumbDown` ISNULL then 0\n    else comment.`thumbDown` \n  end ) as thumbDown\nfrom company left join comment on company.id = comment.`refCompany`\ngroup by company.id\norder by company.created asc"
  }

  // remove
  collection.schema.removeField("plfdoeeb")

  // remove
  collection.schema.removeField("3iivuw1u")

  // remove
  collection.schema.removeField("4gbzlzui")

  // remove
  collection.schema.removeField("gymruwf9")

  // remove
  collection.schema.removeField("p7ks3pjh")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "3srmyl3j",
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
    "id": "ajmlx80b",
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
    "id": "v1xxuyjj",
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
    "id": "aq5vu57j",
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
    "id": "2xwjxcye",
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
  const collection = dao.findCollectionByNameOrId("nfh6oodiwpl747s")

  collection.options = {
    "query": "select \n  company.id, \n  company.name, company.homepage, company.location,\n  sum(\n  case \n    when comment.`thumbUp` ISNULL then 0\n    else comment.`thumbUp` \n  end ) as thumbUp, \n  sum(\n  case \n    when comment.`thumbDown` ISNULL then 0\n    else comment.`thumbDown` \n  end ) as thumbDown\nfrom company left join comment on company.id = comment.`refCompany`\ngroup by company.id\norder by company.created desc"
  }

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "plfdoeeb",
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
    "id": "3iivuw1u",
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
    "id": "4gbzlzui",
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
    "id": "gymruwf9",
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
    "id": "p7ks3pjh",
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
  collection.schema.removeField("3srmyl3j")

  // remove
  collection.schema.removeField("ajmlx80b")

  // remove
  collection.schema.removeField("v1xxuyjj")

  // remove
  collection.schema.removeField("aq5vu57j")

  // remove
  collection.schema.removeField("2xwjxcye")

  return dao.saveCollection(collection)
})
