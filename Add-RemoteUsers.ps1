$users = @(
    "CFE\adan.cortes",
    "CFE\alberto.jimenez",
    "CFE\arelys.achurra",
    "CFE\diana.rivas",
    "CFE\eric.tapia",
    "CFE\jorge.deleon",
    "CFE\katherine.caballero",
    "CFE\kiara.gonzalez",
    "CFE\lourdes.batista",
    "CFE\nathalie.salas",
    "CFE\patricia.castillo"
)

foreach ($user in $users) {
    Add-LocalGroupMember -Group "Usuarios de escritorio remoto" -Member $user
}