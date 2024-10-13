/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("qwoout2gr4tfbqf")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "oionjzgs",
    "name": "desciption",
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
  const collection = dao.findCollectionByNameOrId("qwoout2gr4tfbqf")

  // remove
  collection.schema.removeField("oionjzgs")

  return dao.saveCollection(collection)
})
