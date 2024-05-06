var db = require('./../helpers/db_helpers')
var helper = require('./../helpers/helpers')
var multiparty = require('multiparty')
var fs = require('fs');
var imageSavePath = "./public/img/"
var image_base_url = helper.ImagePath();

const msg_success = "Thành công";
const msg_fail = "Lỗi";

module.exports.controller = (app) => {

    const msg_category_added = "Danh mục được thêm thành công.";
    const msg_category_update = "Danh mục được cập nhật thành công.";
    const msg_category_delete = "Danh mục được xóa thành công.";

    const msg_product_added = "Sản phẩm được thêm thành công.";
    const msg_product_update = "Sản phẩm được cập nhật thành công.";
    const msg_product_delete = "Sản phẩm được xóa thành công.";

    const msg_nutrition_added = "Dinh dưỡng được thêm thành công.";
    const msg_nutrition_update = "Dinh dưỡng được cập nhật thành công.";
    const msg_nutrition_delete = "Dinh dưỡng được xóa thành công.";

    const msg_product_image_added = "Hình ảnh sản phẩm được thêm thành công.";
    const msg_product_image_delete = "Hình ảnh sản phẩm được xóa thành công.";

    const msg_zone_added = "Khu vực được thêm thành công.";
    const msg_zone_update = "Khu vực được cập nhật thành công.";
    const msg_zone_delete = "Khu vực được xóa thành công.";

    const msg_area_added = "Khu vực được thêm thành công.";
    const msg_area_update = "Khu vực được cập nhật thành công.";
    const msg_area_delete = "Khu vực được xóa thành công.";

    const msg_offer_added = "Ưu đãi được thêm thành công.";
    const msg_offer_delete = "Ưu đãi được xóa thành công.";

    const msg_already_added = "Giá trị này đã được thêm vào đây trước đó";
    const msg_added = "Đã được thêm vào đây trước đó";

    const msg_promo_code_added = "Mã khuyến mãi được thêm thành công.";
    const msg_promo_code_update = "Mã khuyến mãi được cập nhật thành công.";
    const msg_promo_code_delete = "Mã khuyến mãi được xóa thành công.";

    app.post("/api/admin/product_category_add", (req, res) => {
        var form = new multiparty.Form();

        checkAccessToken(req.headers, res => {

            form.parse(req, (err, reqObj, files) => {
                if (err) {
                    helper.ThrowHtmlError(err, res);
                    return
                }

                helper.Dlog("---------- Parameter ----")
                helper.Dlog(reqObj)
                helper.Dlog("---------- Files ----")
                helper.Dlog(files)

                helper.CheckParameterValid(res, reqObj, ["cat_name", "color"], () => {
                    helper.CheckParameterValid(res, files, ["image"], () => {
                        var extension = files.image[0].originalFilename.substring(files.image[0].originalFilename.lastIndexOf(".") + 1);

                        var imageFileName = "category/" + helper.fileNameGenerate(extension);
                        var newPath = imageSavePath + imageFileName;

                        fs.rename(files.image[0].path, newPath, (err) => {
                            if (err) {
                                helper.ThrowHtmlError(err, res);
                                return
                            } else {
                                db.query("INSERT INTO `category_detail`( `cat_name`, `image`, `color`, `created_date`, `modify_date`) VALUES  (?,?,?, NOW(), NOW())", [
                                    reqObj.cat_name[0], imageFileName, reqObj.color[0]
                                ], (err, result) => {

                                    if (err) {
                                        helper.ThrowHtmlError(err, res);
                                        return;
                                    }

                                    if (result) {
                                        res.json({
                                            "status": "1", "payload": {
                                                "cat_id": result.insertId,
                                                "cat_name": reqObj.cat_name[0],
                                                "color": reqObj.color[0],
                                                "image": helper.ImagePath() + imageFileName,
                                            }, "message": msg_category_added
                                        });
                                    } else {
                                        res.json({ "status": "0", "message": msg_fail })
                                    }

                                })
                            }
                        })
                    })
                })

            })

        })
    })

    app.post("/api/admin/product_category_update", (req, res) => {
        var form = new multiparty.Form();

        checkAccessToken(req.headers, res, (uObj) => {

            form.parse(req, (err, reqObj, files) => {
                if (err) {
                    helper.ThrowHtmlError(err, res);
                    return
                }

                helper.Dlog("---------- Parameter ----")
                helper.Dlog(reqObj)
                helper.Dlog("---------- Files ----")
                helper.Dlog(files)

                helper.CheckParameterValid(res, reqObj, ["cat_id", "cat_name", "color"], () => {

                    var condition = "";
                    var imageFileName = "";

                    if (files.image != undefined || files.image != null) {
                        var extension = files.image[0].originalFilename.substring(files.image[0].originalFilename.lastIndexOf(".") + 1);

                        imageFileName = "category/" + helper.fileNameGenerate(extension);
                        var newPath = imageSavePath + imageFileName;

                        condition = " `image` = '" + imageFileName + "', ";
                        fs.rename(files.image[0].path, newPath, (err) => {
                            if (err) {
                                helper.ThrowHtmlError(err);
                                return
                            } else {

                            }
                        })
                    }


                    db.query("UPDATE `category_detail` SET `cat_name`=?," + condition + " `color`=?,`modify_date`=NOW() WHERE `cat_id`= ? AND `status` = ?", [
                        reqObj.cat_name[0], reqObj.color[0], reqObj.cat_id[0], "1"
                    ], (err, result) => {

                        if (err) {
                            helper.ThrowHtmlError(err, res);
                            return;
                        }

                        if (result) {
                            res.json({
                                "status": "1", "payload": {
                                    "cat_id": parseInt(reqObj.cat_id[0]),
                                    "cat_name": reqObj.cat_name[0],
                                    "color": reqObj.color[0],
                                    "image": helper.ImagePath() + imageFileName,
                                }, "message": msg_category_update
                            });
                        } else {
                            res.json({ "status": "0", "message": msg_fail })
                        }

                    })
                })

            })

        })
    })

    app.post('/api/admin/product_category_delete', (req, res) => {
        helper.Dlog(req.body);
        var reqObj = req.body;

        helper.CheckParameterValid(res, reqObj, ["cat_id"], () => {

            checkAccessToken(req.headers, res, (uObj) => {
                db.query("UPDATE `category_detail` SET `status`= ?, `modify_date` = NOW() WHERE `cat_id`= ? ", [
                    "2", reqObj.cat_id,
                ], (err, result) => {

                    if (err) {
                        helper.ThrowHtmlError(err, res);
                        return;
                    }

                    if (result.affectedRows > 0) {
                        res.json({
                            "status": "1", "message": msg_category_delete
                        });
                    } else {
                        res.json({ "status": "0", "message": msg_fail })
                    }

                })
            }, "2")
        })
    })

    app.post('/api/admin/product_category_list', (req, res) => {
        helper.Dlog(req.body);
        var reqObj = req.body;

        checkAccessToken(req.headers, res, (uObj) => {
            db.query("SELECT `cat_id`, `cat_name`,  (CASE WHEN `image` != '' THEN CONCAT('" + helper.ImagePath() + "','',`image`)  ELSE `image` END) AS `image` , `color` FROM `category_detail` WHERE `status`= ? ", [
                "1"
            ], (err, result) => {

                if (err) {
                    helper.ThrowHtmlError(err, res);
                    return;
                }

                res.json({
                    "status": "1", "payload": result
                });
            })
        }, "2")
    })

    app.post("/api/admin/product_add", (req, res) => {
        var form = new multiparty.Form();

        checkAccessToken(req.headers, res, (uObj) => {

            form.parse(req, (err, reqObj, files) => {
                if (err) {
                    helper.ThrowHtmlError(err, res);
                    return
                }

                helper.Dlog("---------- Parameter ----")
                helper.Dlog(reqObj)
                helper.Dlog("---------- Files ----")
                helper.Dlog(files)

                helper.CheckParameterValid(res, reqObj, ["name", "detail", "cat_id", "unit_name", "unit_value", "nutrition_weight", "price", "nutrition_date"], () => {
                    helper.CheckParameterValid(res, files, ["image"], () => {
                        var imageNamePathArr = []
                        var fullImageNamePathArr = [];
                        files.image.forEach(imageFile => {
                            var extension = imageFile.originalFilename.substring(imageFile.originalFilename.lastIndexOf(".") + 1);
                            var imageFileName = "product/" + helper.fileNameGenerate(extension);

                            imageNamePathArr.push(imageFileName);
                            fullImageNamePathArr.push(helper.ImagePath() + imageFileName);
                            saveImage(imageFile, imageSavePath + imageFileName);
                        });

                        helper.Dlog(imageNamePathArr);
                        helper.Dlog(fullImageNamePathArr);

                        db.query("INSERT INTO `product_detail`(`cat_id`, `name`, `detail`, `unit_name`, `unit_value`, `nutrition_weight`, `price`, `created_date`, `modify_date`) VALUES (?, ?, ?, ?, ?, ?, ?, NOW(), NOW())", [reqObj.cat_id[0], reqObj.name[0], reqObj.detail[0], reqObj.unit_name[0], reqObj.unit_value[0], reqObj.nutrition_weight[0], reqObj.price[0]], (err, result) => {
                            if (err) {
                                helper.ThrowHtmlError(err, res);
                                return
                            }

                            if (result) {
                                var nutritionInsertData = []
                                var nutritionDataArr = JSON.parse(reqObj.nutrition_date[0])

                                nutritionDataArr.forEach(nObj => {
                                    nutritionInsertData.push([result.insertId, nObj.name, nObj.value]);
                                });

                                if (nutritionDataArr.length > 0) {
                                    db.query("INSERT INTO `nutrition_detail`(`prod_id`, `nutrition_name`, `nutrition_value`) VALUES ? ", [nutritionInsertData], (err, nResult) => {
                                        if (err) {
                                            helper.ThrowHtmlError(err, res);
                                            return
                                        }

                                        if (nResult) {
                                            helper.Dlog(" nutritionInsert succes");
                                        } else {
                                            // res.json({ "status": "0", "message": msg_fail })
                                            helper.Dlog(" nutritionInsert fail");
                                        }

                                    })
                                }

                                var imageInsertArr = []

                                imageNamePathArr.forEach(imagePath => {
                                    imageInsertArr.push([result.insertId, imagePath]);
                                });

                                db.query("INSERT INTO `image_detail`(`prod_id`, `image`) VALUES ? ", [imageInsertArr], (err, iResult) => {
                                    if (err) {
                                        helper.ThrowHtmlError(err, res);
                                        return
                                    }

                                    if (iResult) {
                                        helper.Dlog("imageInsertArr success");
                                    } else {
                                        helper.Dlog("imageInsertArr fail");
                                    }

                                })

                                res.json({
                                    "status": "1", "message": msg_product_added
                                });

                            } else {
                                res.json({ "status": "0", "message": msg_fail })
                            }
                        })


                    })
                })

            })

        })
    })

    app.post('/api/admin/product_update', (req, res) => {
        helper.Dlog(req.body);
        var reqObj = req.body;

        helper.CheckParameterValid(res, reqObj, ["prod_id", "name", "detail", "cat_id", "unit_name", "unit_value", "nutrition_weight", "price"], () => {

            checkAccessToken(req.headers, res, (uObj) => {

                db.query("UPDATE `product_detail` SET `cat_id`=?, `name`=?,`detail`=?,`unit_name`=?,`unit_value`=?,`nutrition_weight`=?,`price`=?, `modify_date`=NOW() WHERE  `prod_id`= ? AND `status` = ? ", [
                    reqObj.cat_id, reqObj.name, reqObj.detail, reqObj.unit_name, reqObj.unit_value, reqObj.nutrition_weight, reqObj.price, reqObj.prod_id, "1"
                ], (err, result) => {

                    if (err) {
                        helper.ThrowHtmlError(err, res);
                        return;
                    }

                    if (result.affectedRows > 0) {
                        res.json({
                            "status": "1", "message": msg_product_update
                        });
                    } else {
                        res.json({ "status": "0", "message": msg_fail })
                    }

                })
            }, "2")
        })
    })

    app.post('/api/admin/product_delete', (req, res) => {
        helper.Dlog(req.body);
        var reqObj = req.body;

        helper.CheckParameterValid(res, reqObj, ["prod_id"], () => {

            checkAccessToken(req.headers, res, (uObj) => {

                db.query("UPDATE `product_detail` SET `status`=?,`modify_date`=NOW() WHERE  `prod_id`= ? AND `status` = ? ", [
                    "2", reqObj.prod_id, "1"
                ], (err, result) => {

                    if (err) {
                        helper.ThrowHtmlError(err, res);
                        return;
                    }

                    if (result.affectedRows > 0) {
                        res.json({
                            "status": "1", "message": msg_product_delete
                        });
                    } else {
                        res.json({ "status": "0", "message": msg_fail })
                    }

                })
            }, "2")
        })
    })

    app.post('/api/admin/product_nutrition_add', (req, res) => {
        helper.Dlog(req.body);
        var reqObj = req.body;

        helper.CheckParameterValid(res, reqObj, ["prod_id", "nutrition_name", "nutrition_value"], () => {

            checkAccessToken(req.headers, res, (uObj) => {
                db.query("INSERT INTO `nutrition_detail`( `prod_id`, `nutrition_name`, `nutrition_value`, `created_date`, `modify_date`) VALUES (?,?,?, NOW(), NOW())", [
                    reqObj.prod_id, reqObj.nutrition_name, reqObj.nutrition_value
                ], (err, result) => {

                    if (err) {
                        helper.ThrowHtmlError(err, res);
                        return;
                    }

                    if (result) {
                        res.json({
                            "status": "1", "message": msg_nutrition_added
                        });
                    } else {
                        res.json({ "status": "0", "message": msg_fail })
                    }

                })



            }, "2")
        })
    })

    app.post('/api/admin/product_nutrition_update', (req, res) => {
        helper.Dlog(req.body);
        var reqObj = req.body;

        helper.CheckParameterValid(res, reqObj, ["prod_id", "nutrition_id", "nutrition_name", "nutrition_value"], () => {

            checkAccessToken(req.headers, res, (uObj) => {

                db.query("UPDATE `nutrition_detail` SET `nutrition_name`= ?,`nutrition_value`= ?, `modify_date`= NOW() WHERE  `prod_id`= ? AND `nutrition_id` = ? AND `status` = ? ", [
                    reqObj.nutrition_name, reqObj.nutrition_value, reqObj.prod_id, reqObj.nutrition_id, "1"
                ], (err, result) => {

                    if (err) {
                        helper.ThrowHtmlError(err, res);
                        return;
                    }

                    if (result.affectedRows > 0) {
                        res.json({
                            "status": "1", "message": msg_nutrition_update
                        });
                    } else {
                        res.json({ "status": "0", "message": msg_fail })
                    }

                })
            }, "2")
        })
    })

    app.post('/api/admin/product_nutrition_delete', (req, res) => {
        helper.Dlog(req.body);
        var reqObj = req.body;

        helper.CheckParameterValid(res, reqObj, ["prod_id", "nutrition_id"], () => {

            checkAccessToken(req.headers, res, (uObj) => {

                db.query("UPDATE `nutrition_detail` SET `status`= ?, `modify_date`= NOW() WHERE  `prod_id`= ? AND `nutrition_id` = ? AND `status` = ? ", [
                    "2", reqObj.prod_id, reqObj.nutrition_id, "1"
                ], (err, result) => {

                    if (err) {
                        helper.ThrowHtmlError(err, res);
                        return;
                    }

                    if (result.affectedRows > 0) {
                        res.json({
                            "status": "1", "message": msg_nutrition_delete
                        });
                    } else {
                        res.json({ "status": "0", "message": msg_fail })
                    }

                })
            }, "2")
        })
    })

    app.post("/api/admin/product_image_add", (req, res) => {
        var form = new multiparty.Form();

        checkAccessToken(req.headers, res, (uObj) => {

            form.parse(req, (err, reqObj, files) => {
                if (err) {
                    helper.ThrowHtmlError(err, res);
                    return
                }

                helper.Dlog("---------- Parameter ----")
                helper.Dlog(reqObj)
                helper.Dlog("---------- Files ----")
                helper.Dlog(files)

                helper.CheckParameterValid(res, reqObj, ["prod_id"], () => {
                    helper.CheckParameterValid(res, files, ["image"], () => {
                        var extension = files.image[0].originalFilename.substring(files.image[0].originalFilename.lastIndexOf(".") + 1);

                        var imageFileName = "product/" + helper.fileNameGenerate(extension);
                        var newPath = imageSavePath + imageFileName;

                        fs.rename(files.image[0].path, newPath, (err) => {
                            if (err) {
                                helper.ThrowHtmlError(err, res);
                                return
                            } else {
                                db.query("INSERT INTO `image_detail`( `prod_id`, `image`, `created_date`, `modify_date`) VALUES  (?,?, NOW(), NOW())", [
                                    reqObj.prod_id[0], imageFileName
                                ], (err, result) => {

                                    if (err) {
                                        helper.ThrowHtmlError(err, res);
                                        return;
                                    }

                                    if (result) {
                                        res.json({
                                            "status": "1", "message": msg_product_image_added
                                        });
                                    } else {
                                        res.json({ "status": "0", "message": msg_fail })
                                    }

                                })
                            }
                        })
                    })
                })

            })

        })
    })

    app.post('/api/admin/product_image_delete', (req, res) => {
        helper.Dlog(req.body);
        var reqObj = req.body;

        helper.CheckParameterValid(res, reqObj, ["prod_id", "img_id"], () => {

            checkAccessToken(req.headers, res, (uObj) => {
                db.query("UPDATE `image_detail` SET `status`= ?, `modify_date` = NOW() WHERE `prod_id`= ? AND `img_id` = ? AND `status` = ? ", [
                    "2", reqObj.prod_id, reqObj.img_id, "1"
                ], (err, result) => {

                    if (err) {
                        helper.ThrowHtmlError(err, res);
                        return;
                    }

                    if (result.affectedRows > 0) {
                        res.json({
                            "status": "1", "message": msg_product_image_delete
                        });
                    } else {
                        res.json({ "status": "0", "message": msg_fail })
                    }

                })
            }, "2")
        })
    })

    app.post('/api/admin/product_list', (req, res) => {
        helper.Dlog(req.body);

        checkAccessToken(req.headers, res, (uObj) => {
            db.query("SELECT `pd`.`prod_id`, `pd`.`cat_id`, `pd`.`name`, `pd`.`detail`, `pd`.`unit_name`, `pd`.`unit_value`, `pd`.`nutrition_weight`, `pd`.`price`, `pd`.`created_date`, `pd`.`modify_date`, `cd`.`cat_name`FROM `product_detail` AS  `pd` " +
                "INNER JOIN `category_detail` AS `cd` ON `pd`.`cat_id` = `cd`.`cat_id` " +
                "WHERE `pd`.`status` = ? ORDER BY `pd`.`prod_id` DESC ", [
                "1"
            ], (err, result) => {

                if (err) {
                    helper.ThrowHtmlError(err, res);
                    return;
                }

                res.json({
                    "status": "1", "payload": result
                });

            })
        }, "2")

    })

    app.post('/api/admin/product_detail', (req, res) => {
        helper.Dlog(req.body);
        var reqObj = req.body;
        checkAccessToken(req.headers, res, (uObj) => {
            helper.CheckParameterValid(res, reqObj, ["prod_id"], () => {

                getProductDetail(res, reqObj.prod_id);
               
            })
        }, "2")

    })

    function getProductDetail(res, prod_id) {
        db.query("SELECT `pd`.`prod_id`, `pd`.`cat_id`, `pd`.`name`, `pd`.`detail`, `pd`.`unit_name`, `pd`.`unit_value`, `pd`.`nutrition_weight`, `pd`.`price`, `pd`.`created_date`, `pd`.`modify_date`, `cd`.`cat_name` FROM `product_detail` AS  `pd` " +
            "INNER JOIN `category_detail` AS `cd` ON `pd`.`cat_id` = `cd`.`cat_id` " +
            "WHERE `pd`.`status` = ? AND `pd`.`prod_id` = ? ; " +
            
            "SELECT `nutrition_id`, `prod_id`, `nutrition_name`, `nutrition_value` FROM `nutrition_detail` WHERE `prod_id` = ? AND `status` = ? ORDER BY `nutrition_name`;" +
            
            "SELECT `img_id`, `prod_id`, `image` FROM `image_detail` WHERE `prod_id` = ? AND `status` = ? ", [

            "1", prod_id, prod_id, "1", prod_id, "1",

        ], (err, result) => {

            if (err) {
                helper.ThrowHtmlError(err, res);
                return;
            }

            // result = result.replace_null()

            // helper.Dlog(result);
            
            if(result[0].length > 0) {

                result[0][0].nutrition_list = result[1];
                result[0][0].images = result[2];


                res.json({  
                    "status": "1", "payload": result[0][0]
                });
            }else{
                res.json({ "status": "0", "message": "invalid item" })
            }

            

        })
    }

    app.post('/api/admin/offer_add', (req, res) => {
        helper.Dlog(req.body);
        var reqObj = req.body;

        helper.CheckParameterValid(res, reqObj, ["prod_id", "price", "start_date", "end_date" ], () => {

            checkAccessToken(req.headers, res, (uObj) => {

                db.query("INSERT INTO `offer_detail`( `prod_id`, `price`, `start_date`, `end_date`,  `created_date`, `modify_date`) VALUES (?,?,?, ?,NOW(), NOW())", [
                    reqObj.prod_id, reqObj.price, reqObj.start_date, reqObj.end_date
                        ], (err, result) => {

                            if (err) {
                                helper.ThrowHtmlError(err, res);
                                return;
                            }

                            if (result) {
                                res.json({
                                    "status": "1", "message": msg_offer_added
                                });
                            } else {
                                res.json({ "status": "0", "message": msg_fail })
                            }
                        })
            }, "2")
        })
    })

    app.post('/api/admin/offer_delete', (req, res) => {
        helper.Dlog(req.body);
        var reqObj = req.body;

        helper.CheckParameterValid(res, reqObj, ["offer_id"], () => {

            checkAccessToken(req.headers, res, (uObj) => {


                db.query("UPDATE `offer_detail` SET `status`= ?, `modify_date` = NOW() WHERE `offer_id`= ? AND `status` = ? ", [
                    "2", reqObj.offer_id, "1"
                ], (err, result) => {

                    if (err) {
                        helper.ThrowHtmlError(err, res);
                        return;
                    }

                    if (result.affectedRows > 0) {
                        res.json({
                            "status": "1", "message": msg_offer_delete
                        });
                    } else {
                        res.json({ "status": "0", "message": msg_fail })
                    }

                })
            }, "2")
        })
    })

    app.post('/api/admin/offer_list', (req, res) => {
        helper.Dlog(req.body);
        var reqObj = req.body;

        checkAccessToken(req.headers, res, (uObj) => {
            db.query("SELECT `offer_id`, `prod_id`, `price`, `start_date`, `end_date`, `status`, `created_date`, `modify_date` FROM `offer_detail` WHERE `status`= ? ", [
                "1"
            ], (err, result) => {

                if (err) {
                    helper.ThrowHtmlError(err, res);
                    return;
                }

                res.json({
                    "status": "1", "payload": result
                });
            })
        }, "2")
    })

    app.post('/api/admin/promo_code_add', (req, res) => {
        helper.Dlog(req.body)
        var reqObj = req.body

        checkAccessToken(req.headers, res, (userObj) => {
            helper.CheckParameterValid(res, reqObj, ["code", "title", "start_date", "end_date", "description", "type", "min_order_amount", "max_discount_amount", "offer_price"], () => {
                db.query("SELECT `promo_code_id` FROM `promo_code_detail` WHERE `code` = ? AND `status` = 1 ", [reqObj.code,], (err, result) => {
                    if(err) {
                        helper.ThrowHtmlError(err, res)
                        return
                    }

                    if(result.length > 0) {
                        res.json({
                            'status':'0',
                            'message': msg_added
                        })
                    }else{
                        db.query("INSERT INTO `promo_code_detail` (`code`, `title`, `start_date`, `end_date`, `description`, `type`, `min_order_amount`, `max_discount_amount`, `offer_price`) VALUES (?,?,?, ?,?,?, ?,?,?)", [
                            reqObj.code, reqObj.title, reqObj.start_date, reqObj.end_date, reqObj.description, reqObj.type, reqObj.min_order_amount, reqObj.max_discount_amount, reqObj.offer_price
                        ], (err, result) => {

                            if (err) {
                                helper.ThrowHtmlError(err, res)
                                return
                            }

                            if(result) {
                                res.json({
                                    'status': '1',
                                    'message': msg_promo_code_added
                                })
                            }else{
                                res.json({
                                    'status': '0',
                                    'message': msg_fail
                                })
                            }
                        })
                    }
                })
            } )
        }, "2" )
    })

    app.post('/api/admin/promo_code_update', (req, res) => {
        helper.Dlog(req.body)
        var reqObj = req.body

        checkAccessToken(req.headers, res, (userObj) => {
            helper.CheckParameterValid(res, reqObj, ["promo_code_id", "title", "start_date", "end_date", "description", "type", "min_order_amount", "max_discount_amount", "offer_price"], () => {
               
                db.query("UPDATE `promo_code_detail` SET `title`= ?, `start_date`= ? , `end_date`= ?, `description`= ?, `type`= ? , `min_order_amount`= ?, `max_discount_amount`= ? , `offer_price`= ?, `modify_date` = NOW() WHERE `promo_code_id` = ? AND `status` = 1 ", [
                    reqObj.title, reqObj.start_date, reqObj.end_date, reqObj.description, reqObj.type, reqObj.min_order_amount, reqObj.max_discount_amount, reqObj.offer_price, reqObj.promo_code_id
                        ], (err, result) => {

                            if (err) {
                                helper.ThrowHtmlError(err, res)
                                return
                            }

                            if (result.affectedRows > 0) {
                                res.json({
                                    'status': '1',
                                    'message': msg_promo_code_update
                                })
                            } else {
                                res.json({
                                    'status': '0',
                                    'message': msg_fail
                                })
                            }
                        })
                   
            })
        }, "2")
    })

    app.post('/api/admin/promo_code_delete', (req, res) => {
        helper.Dlog(req.body)
        var reqObj = req.body

        checkAccessToken(req.headers, res, (userObj) => {
            helper.CheckParameterValid(res, reqObj, ["promo_code_id"], () => {

                db.query("UPDATE `promo_code_detail` SET `status`= 2 , `modify_date` = NOW() WHERE `promo_code_id` = ? AND `status` = 1 ", [reqObj.promo_code_id
                ], (err, result) => {

                    if (err) {
                        helper.ThrowHtmlError(err, res)
                        return
                    }

                    if (result.affectedRows > 0) {
                        res.json({
                            'status': '1',
                            'message': msg_promo_code_delete
                        })
                    } else {
                        res.json({
                            'status': '0',
                            'message': msg_fail
                        })
                    }
                })

            })
        }, "2")
    })
    
    app.post('/api/admin/promo_code_list', (req, res) => {
        helper.Dlog(req.body)
        var reqObj = req.body

        checkAccessToken(req.headers, res, (userObj) => {
                db.query("SELECT `promo_code_id`, `code`, `title`, `description`, `type`, `min_order_amount`, `max_discount_amount`, `offer_price`, `start_date`, `end_date`, `created_date`, `modify_date` FROM `promo_code_detail` WHERE `status` = 1 ORDER BY `promo_code_id` DESC ", [], (err, result) => {

                    if (err) {
                        helper.ThrowHtmlError(err, res)
                        return
                    }

                    res.json({
                        'status': '1',
                        'payload': result,
                        'message': msg_success
                    })
                })
        }, "2")
    })

    app.post('/api/admin/new_orders_list', (req, res) => {
        helper.Dlog(req.body)
        var reqObj = req.body

        checkAccessToken(req.headers, res, (userObj) => {
            db.query("SELECT `od`.`order_id`,`od`.`user_id`, `od`.`cart_id`, `od`.`total_price`, `od`.`user_pay_price`, `od`.`discount_price`, `od`.`deliver_price`, `od`.`deliver_type`, `od`.`payment_type`, `od`.`payment_status`, `od`.`order_status`, `od`.`status`, `od`.`created_date`, GROUP_CONCAT(DISTINCT `pd`.`name` SEPARATOR ',') AS `names`, GROUP_CONCAT(DISTINCT (CASE WHEN `imd`.`image` != '' THEN  CONCAT( '" + image_base_url + "' ,'', `imd`.`image` ) ELSE '' END) SEPARATOR ',') AS `images`  FROM `order_detail` AS `od` " +
                "INNER JOIN `cart_detail` AS `cd` ON FIND_IN_SET(`cd`.`cart_id`, `od`.`cart_id`) > 0  " +
                "INNER JOIN `product_detail` AS `pd` ON  `cd`.`prod_id` = `pd`.`prod_id` " +
                "INNER JOIN `image_detail` AS `imd` ON  `imd`.`prod_id` = `pd`.`prod_id` " +
                "WHERE (`od`.`payment_type` = 1 OR ( `od`.`payment_type` = 2 AND `od`.`payment_status` = 2 ) ) AND `order_status` <= 2 GROUP BY `od`.`order_id` ORDER BY `od`.`order_id` ", [], (err, result) => {
                    if (err) {
                        helper.ThrowHtmlError(err, res)
                        return
                    }

                    res.json({
                        "status": "1",
                        "payload": result,
                        "message": msg_success
                    })
                })
        },'2')
    })

    app.post('/api/admin/completed_orders_list', (req, res) => {
        helper.Dlog(req.body)
        var reqObj = req.body

        checkAccessToken(req.headers, res, (userObj) => {
            db.query("SELECT `od`.`order_id`, `od`.`user_id`, `od`.`cart_id`, `od`.`total_price`, `od`.`user_pay_price`, `od`.`discount_price`, `od`.`deliver_price`, `od`.`deliver_type`, `od`.`payment_type`, `od`.`payment_status`, `od`.`order_status`, `od`.`status`, `od`.`created_date`, GROUP_CONCAT(DISTINCT `pd`.`name` SEPARATOR ',') AS `names`, GROUP_CONCAT(DISTINCT (CASE WHEN `imd`.`image` != '' THEN  CONCAT( '" + image_base_url + "' ,'', `imd`.`image` ) ELSE '' END) SEPARATOR ',') AS `images`  FROM `order_detail` AS `od` " +
                "INNER JOIN `cart_detail` AS `cd` ON FIND_IN_SET(`cd`.`cart_id`, `od`.`cart_id`) > 0  " +
                "INNER JOIN `product_detail` AS `pd` ON  `cd`.`prod_id` = `pd`.`prod_id` " +
                "INNER JOIN `image_detail` AS `imd` ON  `imd`.`prod_id` = `pd`.`prod_id` " +
                "WHERE (`od`.`payment_type` = 1 OR ( `od`.`payment_type` = 2 AND `od`.`payment_status` = 2 ) ) AND `order_status` = 3 GROUP BY `od`.`order_id` ORDER BY `od`.`order_id` ", [], (err, result) => {
                    if (err) {
                        helper.ThrowHtmlError(err, res)
                        return
                    }

                    res.json({
                        "status": "1",
                        "payload": result,
                        "message": msg_success
                    })
                })
        }, '2')
    })

    app.post('/api/admin/cancel_decline_orders_list', (req, res) => {
        helper.Dlog(req.body)
        var reqObj = req.body

        checkAccessToken(req.headers, res, (userObj) => {
            db.query("SELECT `od`.`order_id`, `od`.`user_id`, `od`.`cart_id`, `od`.`total_price`, `od`.`user_pay_price`, `od`.`discount_price`, `od`.`deliver_price`, `od`.`deliver_type`, `od`.`payment_type`, `od`.`payment_status`, `od`.`order_status`, `od`.`status`, `od`.`created_date`, GROUP_CONCAT(DISTINCT `pd`.`name` SEPARATOR ',') AS `names`, GROUP_CONCAT(DISTINCT (CASE WHEN `imd`.`image` != '' THEN  CONCAT( '" + image_base_url + "' ,'', `imd`.`image` ) ELSE '' END) SEPARATOR ',') AS `images`  FROM `order_detail` AS `od` " +
                "INNER JOIN `cart_detail` AS `cd` ON FIND_IN_SET(`cd`.`cart_id`, `od`.`cart_id`) > 0  " +
                "INNER JOIN `product_detail` AS `pd` ON  `cd`.`prod_id` = `pd`.`prod_id` " +
                "INNER JOIN `image_detail` AS `imd` ON  `imd`.`prod_id` = `pd`.`prod_id` " +
                "WHERE (`od`.`payment_type` = 1 OR ( `od`.`payment_type` = 2 AND `od`.`payment_status` = 2 ) ) AND `order_status` > 3  GROUP BY `od`.`order_id` ORDER BY `od`.`order_id` ", [], (err, result) => {
                    if (err) {
                        helper.ThrowHtmlError(err, res)
                        return
                    }

                    res.json({
                        "status": "1",
                        "payload": result,
                        "message": msg_success
                    })
                })
        }, '2')
    })

    app.post('/api/admin/order_detail', (req, res) => {
        helper.Dlog(req.body)
        var reqObj = req.body

        checkAccessToken(req.headers, res, (userObj) => {
            helper.CheckParameterValid(res, reqObj, ["order_id", "user_id"], () => {


                db.query("SELECT `od`.`order_id`, `od`.`cart_id`, `od`.`total_price`, `od`.`user_pay_price`, `od`.`discount_price`, `od`.`deliver_price`, `od`.`deliver_type`, `od`.`payment_type`, `od`.`payment_status`, `od`.`order_status`, `od`.`status`, `od`.`created_date` FROM `order_detail` AS `od` " +
                    "WHERE `od`.`order_id` = ? AND `od`.`user_id` = ? ;" +

                    "SELECT `uod`.`order_id`, `ucd`.`cart_id`, `ucd`.`user_id`, `ucd`.`prod_id`, `ucd`.`qty`, `pd`.`cat_id`, `pd`.`name`, `pd`.`detail`, `pd`.`unit_name`, `pd`.`unit_value`, `pd`.`nutrition_weight`, `pd`.`price`, `pd`.`created_date`, `pd`.`modify_date`, `cd`.`cat_name`, IFNULL(`od`.`price`, `pd`.`price` ) as `offer_price`, IFNULL(`od`.`start_date`,'') as `start_date`, IFNULL(`od`.`end_date`,'') as `end_date`, (CASE WHEN `od`.`offer_id` IS NOT NULL THEN 1 ELSE 0 END) AS `is_offer_active`, (CASE WHEN `imd`.`image` != '' THEN  CONCAT( '" + image_base_url + "' ,'', `imd`.`image` ) ELSE '' END) AS `image`, (CASE WHEN `od`.`price` IS NULL THEN `pd`.`price` ELSE `od`.`price` END) as `item_price`, ( (CASE WHEN `od`.`price` IS NULL THEN `pd`.`price` ELSE `od`.`price` END) * `ucd`.`qty`)  AS `total_price` FROM `order_detail` AS `uod` " +
                    "INNER JOIN `cart_detail` AS `ucd` ON FIND_IN_SET(`ucd`.`cart_id`, `uod`.`cart_id`) > 0  " +
                    "INNER JOIN `product_detail` AS `pd` ON `pd`.`prod_id` = `ucd`.`prod_id` AND `pd`.`status` = 1  " +
                    "INNER JOIN `category_detail` AS `cd` ON `pd`.`cat_id` = `cd`.`cat_id` " +
                    
                    "LEFT JOIN `offer_detail` AS `od` ON `pd`.`prod_id` = `od`.`prod_id` AND `od`.`status` = 1 AND `od`.`start_date` <= NOW() AND `od`.`end_date` >= NOW() " +
                    "INNER JOIN `image_detail` AS `imd` ON `pd`.`prod_id` = `imd`.`prod_id` AND `imd`.`status` = 1 " +
                    "WHERE `uod`.`order_id` = ? AND `uod`.`user_id` = ? GROUP BY `ucd`.`cart_id`, `pd`.`prod_id`", [reqObj.order_id, reqObj.user_id, reqObj.order_id, reqObj.user_id], (err, result) => {
                        if (err) {
                            helper.ThrowHtmlError(err, res)
                            return
                        }

                        if (result[0].length > 0) {

                            result[0][0].cart_list = result[1]

                            res.json({
                                "status": "1",
                                "payload": result[0][0],
                                "message": msg_success
                            })
                        } else {
                            res.json({
                                'status': '0',
                                'message': 'Đơn hàng không hợp lệ'
                            })
                        }
                })
            })
        },'2')
    })

    app.post('/api/admin/order_status_change', (req, res) => {
        helper.Dlog(req.body)
        var reqObj = req.body

        checkAccessToken(req.headers, res, (userObj) => {
            helper.CheckParameterValid(res, reqObj, ["order_id", "user_id", "order_status"], () => {
                db.query("UPDATE `order_detail` SET `order_status`= ?,`modify_date`= NOW() WHERE `order_id` = ? AND `user_id` = ? AND `order_status` < ? ", [reqObj.order_status, reqObj.order_id, reqObj.user_id, reqObj.order_status] , (err, result) => {
                    if(err) {
                        helper.ThrowHtmlError(err, res);
                        return
                    }

                    if(result.affectedRows > 0) {

                        var title = ""
                        var message = ""
                        var notiType = 2
                        //1: new, 2: order_accept, 3: order_delivered, 4: cancel, 5: order declined	
                        switch (reqObj.order_status) {
                            case "2":
                                title = "Đơn hàng được chấp nhận"
                                message = "Đơn hàng #" + reqObj.order_id +" được chấp nhận."
                                break;
                            case "3":
                                title = "Đơn hàng đã chuyển đến"
                                message = "Đơn hàng #" + reqObj.order_id + " đã giao."
                                break;
                            case "4":
                                title = "Huỷ đơn hàng"
                                message = "Đơn hàng #" + reqObj.order_id + " đã huỷ."
                                break;
                            case "5":
                                title = "Đơn hàng bị từ chối"
                                message = "Đơn hàng #" + reqObj.order_id + " đã từ chối."
                                break;
                            default:
                                break;
                        }

                        db.query("INSERT INTO `notification_detail`( `ref_id`, `user_id`, `title`, `message`, `notification_type`) VALUES (?,?,?, ?,?)", [reqObj.order_id, reqObj.user_id, title, message, notiType  ] , (err, iResult) => {
                            if (err) {
                                helper.ThrowHtmlError(err);
                                return
                            }

                            if (iResult) {
                                helper.Dlog("Thêm thông báo thành công")
                            }else{
                                helper.Dlog("Thông báo lỗi")
                            }
                        } )

                        res.json({
                            "status":"1",
                            "message": "Trạng thái đơn hàng được cập nhật thành công"
                        })
                    }else{
                        res.json({
                            "status": "0",
                            "message": msg_fail
                        })
                    }
                } )
            } )
        },'2')
    } )
}

function saveImage(imageFile, savePath) {
    fs.rename(imageFile.path, savePath, (err) => {

        if (err) {
            helper.ThrowHtmlError(err);
            return;
        }
    })
}

function checkAccessToken(headerObj, res, callback, require_type = "") {
    helper.Dlog(headerObj.access_token);
    helper.CheckParameterValid(res, headerObj, ["access_token"], () => {
        db.query("SELECT `user_id`, `username`, `user_type`, `name`, `email`, `mobile`, `mobile_code`,  `auth_token`, `dervice_token`, `status` FROM `user_detail` WHERE `auth_token` = ? AND `status` = ? ", [headerObj.access_token, "1"], (err, result) => {
            if (err) {
                helper.ThrowHtmlError(err, res);
                return
            }

            helper.Dlog(result);

            if (result.length > 0) {
                if (require_type != "") {
                    if (require_type == result[0].user_type) {
                        return callback(result[0]);
                    } else {
                        res.json({ "status": "0", "code": "404", "message": "Access denied. Unauthorized user access." })
                    }
                } else {
                    return callback(result[0]);
                }
            } else {
                res.json({ "status": "0", "code": "404", "message": "Access denied. Unauthorized user access." })
            }
        })
    })
}