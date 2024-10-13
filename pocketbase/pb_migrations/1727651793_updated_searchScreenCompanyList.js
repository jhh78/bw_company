/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("nfh6oodiwpl747s")

  collection.options = {
    "query": "select \n  company.id, \n  company.name, company.homepage, company.location,\n  sum(\n  case \n    when comment.`thumbUp` ISNULL then 0\n    else comment.`thumbUp` \n  end ) as thumbUp, \n  sum(\n  case \n    when comment.`thumbDown` ISNULL then 0\n    else comment.`thumbDown` \n  end ) as thumbDown\nfrom company left join comment on company.id = comment.`refCompany`\ngroup by company.id\norder by  thumbUp desc"
  }

  // remove
  collection.schema.removeField("cam1px1d")

  // remove
  collection.schema.removeField("0ou3j3on")

  // remove
  collection.schema.removeField("2yv7oht4")

  // remove
  collection.schema.removeField("f4pbj49o")

  // remove
  collection.schema.removeField("oitxotyq")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "ldrh6hc7",
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
    "id": "hvv7rk6d",
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
    "id": "zwwlehqk",
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
    "id": "vbloareg",
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
    "id": "beyhssm8",
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
    "query": "select \n  company.id, \n  company.name, company.homepage, company.location,\n  sum(\n  case \n    when comment.`thumbUp` ISNULL then 0\n    else comment.`thumbUp` \n  end ) as thumbUp, \n  sum(\n  case \n    when comment.`thumbDown` ISNULL then 0\n    else comment.`thumbDown` \n  end ) as thumbDown\nfrom company left join comment on company.id = comment.`refCompany`\ngroup by company.id\norder by company.name "
  }

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "cam1px1d",
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
    "id": "0ou3j3on",
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
    "id": "2yv7oht4",
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
    "id": "f4pbj49o",
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
    "id": "oitxotyq",
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
  collection.schema.removeField("ldrh6hc7")

  // remove
  collection.schema.removeField("hvv7rk6d")

  // remove
  collection.schema.removeField("zwwlehqk")

  // remove
  collection.schema.removeField("vbloareg")

  // remove
  collection.schema.removeField("beyhssm8")

  return dao.saveCollection(collection)
})
