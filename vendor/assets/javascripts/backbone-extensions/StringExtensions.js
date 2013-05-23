String.prototype.toAmericanDate = function() {
    if ( "" == this )
        return ""

    var parts = this.split("T")[0].split("-");
    return parts[1] + "/" + parts[2] + '/' + parts[0];
}

String.prototype.toAmericanDateTime = function() {
    if ( "" == this )
        return ""

    var date_part = this.split("T")[0].split("-");
    var hour_part = this.split('T')[1].split(":");

    return date_part[1] + "/" + date_part[2] + '/' + date_part[0] + ' ' + hour_part[0] + ":" + hour_part[1];
}