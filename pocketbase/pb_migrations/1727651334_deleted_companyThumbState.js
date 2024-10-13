/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db);
  const collection = dao.findCollectionByNameOrId("p8dsjwo1k2usa8f");

  return dao.deleteCollection(collection);
}, (db) => {
  const collection = new Collection({
    "id": "p8dsjwo1k2usa8f",
    "created": "2024-09-28 23:24:29.730Z",
    "updated": "2024-09-29 23:04:35.362Z",
    "name": "companyThumbState",
    "type": "view",
    "system": false,
    "schema": [
      {
        "system": false,
        "id": "fu4d3dyp",
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
      },
      {
        "system": false,
        "id": "pemjgc6v",
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
      },
      {
        "system": false,
        "id": "pr4bzal8",
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
      },
      {
        "system": false,
        "id": "em9nmyzc",
        "name": "thumbUp",
        "type": "json",
        "required": false,
        "presentable": false,
        "unique": false,
        "options": {
          "maxSize": 1
        }
      },
      {
        "system": false,
        "id": "6ajn5juc",
        "name": "thumbDown",
        "type": "json",
        "required": false,
        "presentable": false,
        "unique": false,
        "options": {
          "maxSize": 1
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
      "query": "select \n  company.id, \n  company.name, company.homepage, company.location,\n  sum(\n  case \n    when comment.`thumbUp` ISNULL then 0\n    else comment.`thumbUp` \n  end ) as thumbUp, \n  sum(\n  case \n    when comment.`thumbDown` ISNULL then 0\n    else comment.`thumbDown` \n  end ) as thumbDown\nfrom company left join comment on company.id = comment.`refCompany`\ngroup by company.id"
    }
  });

  return Dao(db).saveCollection(collection);
})
