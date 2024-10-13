/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("hbli4s8c3u3rxis")

  collection.name = "companyNameAutoCompleat"

  // remove
  collection.schema.removeField("eqvyv2ax")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "b6mmr5km",
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

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("hbli4s8c3u3rxis")

  collection.name = "searchScreenCompanyNameAutoCompleat"

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "eqvyv2ax",
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

  // remove
  collection.schema.removeField("b6mmr5km")

  return dao.saveCollection(collection)
})
