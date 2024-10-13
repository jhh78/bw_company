/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const collection = new Collection({
    "id": "p8dsjwo1k2usa8f",
    "created": "2024-09-28 23:24:29.730Z",
    "updated": "2024-09-28 23:24:29.730Z",
    "name": "companyThumbState",
    "type": "view",
    "system": false,
    "schema": [
      {
        "system": false,
        "id": "hj57wwqe",
        "name": "refCompany",
        "type": "relation",
        "required": false,
        "presentable": false,
        "unique": false,
        "options": {
          "collectionId": "gjdz4ct0k8xik52",
          "cascadeDelete": false,
          "minSelect": null,
          "maxSelect": 1,
          "displayFields": null
        }
      }
    ],
    "indexes": [],
    "listRule": null,
    "viewRule": null,
    "createRule": null,
    "updateRule": null,
    "deleteRule": null,
    "options": {
      "query": "select id, comment.`refCompany`\nfrom comment"
    }
  });

  return Dao(db).saveCollection(collection);
}, (db) => {
  const dao = new Dao(db);
  const collection = dao.findCollectionByNameOrId("p8dsjwo1k2usa8f");

  return dao.deleteCollection(collection);
})
