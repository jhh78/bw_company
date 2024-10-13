/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const collection = new Collection({
    "id": "mcij52cxzu3pwi5",
    "created": "2024-09-28 04:39:27.717Z",
    "updated": "2024-09-28 04:39:27.722Z",
    "name": "connection",
    "type": "view",
    "system": false,
    "schema": [],
    "indexes": [],
    "listRule": "",
    "viewRule": null,
    "createRule": null,
    "updateRule": null,
    "deleteRule": null,
    "options": {
      "query": "SELECT (ROW_NUMBER() OVER()) as id;"
    }
  });

  return Dao(db).saveCollection(collection);
}, (db) => {
  const dao = new Dao(db);
  const collection = dao.findCollectionByNameOrId("mcij52cxzu3pwi5");

  return dao.deleteCollection(collection);
})
