
var fs = require('fs');
var cheerio = require('cheerio');

fs.readFile('src', 'utf8', function (err,data) {
    if (err) {
        return console.log(err);
    }

    var file = fs.createWriteStream('navne.txt');
    file.on('error', function(err) { console.log(err); });

    var $ = cheerio.load(data, { decodeEntities: false });
    $("div.fsl.fwb.fcb > a").each(function (index, obj) {
        var str = $(obj).html();
        file.write(str + '\n');
    });

    file.end();
});
