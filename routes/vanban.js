var express = require('express');
var router = express.Router();
const con = require('../controller/connectDB')



// localhost:3000/vanban
router.get('/', function (req, res, next) {
    if (req.isAuthenticated()) {
        var quyen = req.session.passport.user.id_auth;
        var taikhoan = req.session.passport.user.username;
        con.query('SELECT ow.*, vi.id as idVi, vi.*, nameAc \
                    FROM land_violation vi, land_owner ow, account acc \
                    WHERE vi.id_chudat = ow.cmnd and vi.tinhtrang >= 1 \
                        AND vi.id_acc = acc.username order by vi.thoigianthuc DESC ', function (error, results) {
            if (error) { throw (error); }
            else {
                 con.query("SELECT ow.*, vi.id as idVi, vi.*, nameAc \
                            FROM land_violation vi, land_owner ow, account acc \
                            WHERE vi.id_chudat = ow.cmnd and vi.tinhtrang >= 1 \
                                AND vi.id_acc = acc.username and acc.username = '" + taikhoan + "'order by vi.thoigianthuc DESC ", function (error, results2) {
                    if (error) { throw (error); }
                    else {
                        console.log(results2);
                        res.render('vanban', { results, quyen, results2, taikhoan });
                    }
                });
            };
        });
    } else {
        res.redirect('../')
    }

})

router.get('/xem', (req, res) => {

    res.redirect('../');
})

// localhost:3000/vanban/hoso/:cmnd/:idVi
router.get('/xem/:cmnd/:idVi', (req, res) => {

    if (req.isAuthenticated()) {
        var idVi = req.params.idVi;
        con.query("SELECT * FROM docs \
                    WHERE id_violation = '" + idVi + "' \
                    ORDER BY count_views ASC", (err, results) => {
            if (err) { throw err; }
            else {
                
                con.query("SELECT * FROM land_owner, land_violation \
                            WHERE id = " + idVi + " \
                            AND cmnd = id_chudat", (err2, results2) => {
                    if (err2) { throw err2 }
                    console.log(results[0].url);
                    console.log(results[1].url);
                    console.log(results[2].url);
                    console.log(results[3].url);
                    console.log(results[4].url);
                    // console.log(results[5].url);
                    // console.log(results[6].url);
                    console.log('---------------');
                    res.render('xem', { results, results2 })
                })
            }
        })
    } else {
        res.redirect('../')
    }
})

module.exports = router;
