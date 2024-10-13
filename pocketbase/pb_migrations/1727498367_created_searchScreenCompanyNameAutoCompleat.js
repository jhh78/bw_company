/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const collection = new Collection({
    "id": "hbli4s8c3u3rxis",
    "created": "2024-09-28 04:39:27.717Z",
    "updated": "2024-09-28 04:39:27.726Z",
    "name": "searchScreenCompanyNameAutoCompleat",
    "type": "view",
    "system": false,
    "schema": [
      {
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
      }
    ],
    "indexes": [],
    "listRule": "",
    "viewRule": null,
    "createRule": null,
    "updateRule": null,
    "deleteRule": null,
    "options": {
      "query": "select id, name from company;"
    }
  });

  return Dao(db).saveCollection(collection);
}, (db) => {
  const dao = new Dao(db);
  const collection = dao.findCollectionByNameOrId("hbli4s8c3u3rxis");

  return dao.deleteCollection(collection);
})
