var express = require('express');
var router = express.Router();
var bodyParser = require('body-parser');
var Docxtemplater = require("docxtemplater");
var JSZip = require('jszip');
var fs = require('fs');
const upLoadDrive = require('../controller/uploadDrive');
const con = require('../controller/connectDB')
// create application/json parser
var jsonParser = bodyParser.json()
// create application/x-www-form-urlencoded parser
var urlencodedParser = bodyParser.urlencoded({ extended: false })



// localhost:3000/quan
router.get('/', (req, res) => {

    if (req.isAuthenticated() && req.session.passport.user.id_auth == '1') {
        var taikhoan = req.session.passport.user.username;
        con.query('SELECT *, wd.id as idWD, im.id as idIM \
                    FROM `work_daily` wd left join `images` im on wd.id = im.id_WD, `account` acc \
                    WHERE wd.id_acc = acc.username \
                    ORDER BY ngayTT DESC, thoigianthuc DESC', (err, results) => {
                if (err) throw err;
                else {
                    con.query('SELECT * FROM `account` \
                            WHERE id_auth = 2 \
                            ORDER BY `count_acc` asc', (err, results_acc) => {
                            console.log(results);
                            res.render('trangchuQuan', { results, results_acc, taikhoan });

                        })
                }
            })
    }
    else {
        res.redirect('../')
    }
});


// localhost:3000/quan/xuphatquan
/* dislay info land owner */
router.get('/xuphatquan', function (req, res, next) {

    if (req.isAuthenticated() && req.session.passport.user.id_auth == '1') {
        var taikhoan = req.session.passport.user.username;
        con.query('SELECT *, vi.id as idVi, nameAc \
                    FROM land_violation vi LEFT JOIN images im ON vi.id = im.id_Vi LEFT JOIN code_doc cd ON cd.id_violation = vi.id ,land_owner ow, account acc \
                    WHERE vi.id_chudat = ow.cmnd AND vi.id_acc = acc.username \
                    ORDER BY vi.tinhtrang ASC, vi.thoigianthuc DESC', function (error, results, field) {
                if (error) {
                    throw error;
                } else {
                    // console.log(results)
                    con.query("select * from content", (err, results_content) => {
                        if (err) { throw err; }
                        // console.log(results_content)
                        res.render('xuphatQuan', { results, results_content, taikhoan });
                    })
                }
            });
    }
    else {
        res.redirect('/')
    }
});


// submit Docx
function LoadFile(sourceFile, name_sc, name, data) {
    fs.readFile(sourceFile, 'binary', function (err, content) {
        if (err)
            throw (err);
        let zip = new JSZip(content);
        let doc = new Docxtemplater();
        doc.loadZip(zip);

        doc.setData(data);
        try {
            doc.render();
        }
        catch (err) {
            console.log(err);
        }
        let buf = doc.getZip().generate({ type: 'nodebuffer' });
        fs.writeFile(name_sc + '/' + name + '.docx', buf, function (err) {
            if (err)
                throw (err);

        })

    });
}



//Action apply docs
router.post('/duyet', function (req, res, next) {
    var bdparams = req.body;
    var idViD = bdparams.idViD;
    var ngoixung;
    var ngoixungH;
    if (req.body.gioitinhD == 'Nam') {
        ngoixung = 'ông';
        ngoixungH = 'Ông';
    }

    else {
        ngoixung = 'bà';
        ngoixungH = 'Bà';
    }

    //path save docs 
    var file = './public/vanban/xem/';
    var congvanUBNDphuong = 'congvanUBNDphuong_' + bdparams.cmndD + '_' + idViD;
    var phanloaihoso = 'phanloaihoso_' + bdparams.cmndD + '_' + idViD;
    var phieukiemsoat = 'phieukiemsoat_' + bdparams.cmndD + '_' + idViD;
    var QDXP = 'QDXP_' + bdparams.cmndD + '_' + idViD;
    var TTXPVPHC = 'TTXPVPHC_' + bdparams.cmndD + '_' + idViD;
    var TTQDCC = 'TTQDCC_' + bdparams.cmndD + '_' + idViD;
    var QDCC = 'QDCC_' + bdparams.cmndD + '_' + idViD;

    //json data is got data from broswer 
    var data = {
        //Info Owner
        hoten: bdparams.hotenD,
        cmnd: bdparams.cmndD,
        ngaycap: bdparams.ngaycapD,
        diachicap: bdparams.diachicapD,
        ngaysinh: bdparams.ngaysinhD,
        gioitinh: bdparams.gioitinhD,
        diachiTT: bdparams.diachiD,
        quoctich: bdparams.quoctichD,

        //info land Violation::
        diachiVP: bdparams.diachiViD,
        thoigianVP: bdparams.thoigianVPD,
        thoigianLBB: bdparams.thoigianLBBD,
        noidung: [
            { noidung1: bdparams.noidungVPD[0] },
            { noidung1: bdparams.noidungVPD[1] },
            { noidung1: bdparams.noidungVPD[2] },
            { noidung1: bdparams.noidungVPD[3] },
        ],

        tienphat: bdparams.tienphatD,
        ngoixung: ngoixung,
        ngoixungH: ngoixungH,
        phuong: bdparams.nameAcD,
        soBB: bdparams.soBBD,
        hientrangCT: bdparams.hientrangCTD,
        gioLBB: bdparams.gioLBBD,
        soTTQDXP: bdparams.soTTQDXPD,
        ngayTTQDXP: bdparams.ngayTTQDXPD,
        soQDXP: bdparams.soQDXPD,
        ngayQDXP: bdparams.ngayQDXPD,
        // soTTQDCC: bdparams.soTTQDCCD,
        // ngayTTQDCC: bdparams.ngayTTQDCCD,
        // soQDCC: bdparams.soQDCCD,
        // ngayQDCC: bdparams.ngayQDCCD,
    };




    // when btn "Xuất QDCC" action
    if (bdparams.btnQDXP != undefined) {

        // create file congvanUBNDphuong.docx ứng với Mã Vi phạm
        LoadFile('./public/vanban/duyet/congvanUBNDphuong.docx', file, congvanUBNDphuong, data);
        // create file phanloaihoso.docx ứng với Mã Vi phạm
        LoadFile('./public/vanban/duyet/phanloaihoso.docx', file, phanloaihoso, data);
        // create file phieukiemsoat.docx ứng với Mã Vi phạm
        LoadFile('./public/vanban/duyet/phieukiemsoat.docx', file, phieukiemsoat, data);
        // create file QDXP.docx ứng với Mã Vi phạm
        LoadFile('./public/vanban/duyet/QDXP.docx', file, QDXP, data);
        // create file TTXPVPHC.docx ứng với Mã Vi phạm
        LoadFile('./public/vanban/duyet/TTXPVPHC.docx', file, TTXPVPHC, data);



        //Upload docs into Drive (acc: smartcitytphcm@gmail.com; pass:tanphu123456789)
        setTimeout(function () {
            upLoadDrive(file + congvanUBNDphuong + '.docx', congvanUBNDphuong + '.docx', idViD, 0)
            upLoadDrive(file + phanloaihoso + '.docx', phanloaihoso + '.docx', idViD, 1)
            upLoadDrive(file + phieukiemsoat + '.docx', phieukiemsoat + '.docx', idViD, 2)
            upLoadDrive(file + TTXPVPHC + '.docx', TTXPVPHC + '.docx', idViD, 3)
            upLoadDrive(file + QDXP + '.docx', QDXP + '.docx', idViD, 4)
        }, 400);

        // Update status violation 0 => 1 (mới => đợi duyệt QDXP)
        if (bdparams.soTTQDXP != '')
            con.query("UPDATE `land_violation` SET `tinhtrang`= 1 WHERE id = " + idViD, (err) => {
                if (err) {
                    console.log('fail update status = 1');
                    throw err;
                }
            });
    }

    console.log(bdparams);
    // when btn "Xuất QDXP" action
    if (bdparams.btnQDCC != undefined) {
        // create file TTQDCC.docx ứng với Mã Vi phạm
        LoadFile('./public/vanban/duyet/TTQDCC.docx', file, TTQDCC, data);
        // create file QDCC.docx ứng với Mã Vi phạm
        LoadFile('./public/vanban/duyet/QDCC.docx', file, QDCC, data);


        //Upload docs into Drive (acc: smartcitytphcm@gmail.com; pass:tanphu123456789)
        setTimeout(function () {
            upLoadDrive(file + TTQDCC + '.docx', TTQDCC + '.docx', idViD, 5)
            upLoadDrive(file + QDCC + '.docx', QDCC + '.docx', idViD, 6)
        }, 200);

        // Update status violation 2 => 3 (đã xử lý QĐXP => Đợi duyệt QDCC)
        if (bdparams.soTTQDCC != '')
            con.query("UPDATE `land_violation` SET `tinhtrang`= 3 WHERE id = " + idViD, (err) => {
                if (err) {
                    console.log('fail update status = 3');
                    throw err;
                }

            });
    };

    res.redirect('../quan/xuphatQuan');
});

router.post('/Add', function (req, res, next) {
    var bdparams = req.body;
    var idVi = bdparams.idViD;
    var soTTQDXP = bdparams.soTTQDXPD;
    var ngayTTQDXP = bdparams.ngayTTQDXPD;
    var soQDXP = bdparams.soQDXPD;
    var ngayQDXP = bdparams.ngayQDXPD;
    var soTTQDCC = bdparams.soTTQDCCD;
    var ngayTTQDCC = bdparams.ngayTTQDCCD;
    var soQDCC = bdparams.soQDCCD;
    var ngayQDCC = bdparams.ngayQDCCD;


    function returnNull(bodypr) {
        if (bodypr == '')
            bodypr = null;
        return bodypr;
    }
    // return null if value ''
    soTTQDXP = returnNull(soTTQDXP);
    soQDXP = returnNull(soQDXP);
    soTTQDCC = returnNull(soTTQDCC);
    soQDCC = returnNull(soQDCC);

    console.log('data:::' + ngayQDCC)
    con.query('DELETE FROM `code_doc` WHERE id_violation = ' + idVi, (err) => {
        if (err) throw err;
        else {
            con.query("INSERT INTO `code_doc`(`soTTQDXP`, `ngayTTQDXP`, `soQDXP`, `ngayQDXP`, `soTTQDCC`, `ngayTTQDCC`, `soQDCC`, `ngayQDCC`, `id_violation`) \
            VALUES ("+ soTTQDXP + ", '" + ngayTTQDXP + "', " + soQDXP + ", '" + ngayQDXP + "'," + soTTQDCC + ", '" + ngayTTQDCC + "'," + soQDCC + ", '" + ngayQDCC + "'," + idVi + ")", (err) => {
                    if (err) throw err;
                    else {

                        if (soQDXP != null)
                            con.query("UPDATE `land_violation` SET `tinhtrang`= 2 WHERE id = " + idVi, (err) => {
                                if (err) {
                                    console.log('fail update status = 2');
                                    throw err;
                                }
                            });
                        if (soQDCC != null)
                            con.query("UPDATE `land_violation` SET `tinhtrang`= 4 WHERE id = " + idVi, (err) => {
                                if (err) {
                                    console.log('fail update status = 4');
                                    throw err;
                                }
                            });
                    }
                });
            res.redirect('/quan/xuphatquan');
        }
        console.log('Xóa thành công!!');
    });
});

module.exports = router;
