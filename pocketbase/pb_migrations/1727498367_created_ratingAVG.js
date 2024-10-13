/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const collection = new Collection({
    "id": "75ctdd8m1z9utta",
    "created": "2024-09-28 04:39:27.717Z",
    "updated": "2024-09-28 04:39:27.724Z",
    "name": "ratingAVG",
    "type": "view",
    "system": false,
    "schema": [
      {
        "system": false,
        "id": "hq8sotls",
        "name": "careerRating",
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
        "id": "u47u4lpz",
        "name": "corporateCultureRating",
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
        "id": "o8zmqnm5",
        "name": "salaryWelfareRating",
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
        "id": "aomyuzhu",
        "name": "managementRating",
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
        "id": "95f2qpml",
        "name": "workingEnvironmentRating",
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
    "viewRule": "",
    "createRule": null,
    "updateRule": null,
    "deleteRule": null,
    "options": {
      "query": "SELECT \n  r.`refCompany` as id, \n  AVG(r.`careerRating`) as careerRating,\n  AVG(r.`corporateCultureRating`) as corporateCultureRating,\n  AVG(r.`salaryWelfareRating`) as salaryWelfareRating,\n  AVG(r.`managementRating`) as managementRating,\n  AVG(r.`workingEnvironmentRating`) as workingEnvironmentRating\nfrom rating r\nGROUP by r.`refCompany`"
    }
  });

  return Dao(db).saveCollection(collection);
}, (db) => {
  const dao = new Dao(db);
  const collection = dao.findCollectionByNameOrId("75ctdd8m1z9utta");

  return dao.deleteCollection(collection);
})
