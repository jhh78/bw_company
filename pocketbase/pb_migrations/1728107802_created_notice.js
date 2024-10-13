/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const collection = new Collection({
    "id": "qwoout2gr4tfbqf",
    "created": "2024-10-05 05:56:42.894Z",
    "updated": "2024-10-05 05:56:42.894Z",
    "name": "notice",
    "type": "base",
    "system": false,
    "schema": [
      {
        "system": false,
        "id": "m04ziazm",
        "name": "contents",
        "type": "editor",
        "required": false,
        "presentable": false,
        "unique": false,
        "options": {
          "convertUrls": false
        }
      }
    ],
    "indexes": [],
    "listRule": null,
    "viewRule": null,
    "createRule": null,
    "updateRule": null,
    "deleteRule": null,
    "options": {}
  });

  return Dao(db).saveCollection(collection);
}, (db) => {
  const dao = new Dao(db);
  const collection = dao.findCollectionByNameOrId("qwoout2gr4tfbqf");

  return dao.deleteCollection(collection);
})
