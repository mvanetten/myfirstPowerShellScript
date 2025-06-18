#
# Author : M van Etten
#⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⣶⣦⣄⡀⠀⠀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
#⠀⠀⠀⠀⠀⠀⠺⣿⣿⣿⣷⡆⢸⣿⣿⣿⣿⡆⢀⣿⣷⣄⠀⠀⠀⠀⠀⠀⠀⠀
#⠀⠀⠀⠀⣀⣤⣀⠘⢿⣿⣿⡇⢸⣿⣿⣿⡟⠀⣼⣿⣿⣿⣆⠀⠀⠀⠀⠀⠀⠀
#⠀⠀⠠⣾⣿⣿⣿⣧⠈⢿⣿⠃⢸⣿⣿⠟⢀⣾⣿⣿⣿⣿⣿⠀⠀⣤⠀⠀⠀⠀
#⠀⠀⢀⣀⣈⠙⠻⣿⠆⠘⠋⠀⠙⠛⢁⣤⣿⣿⣿⣿⡿⠟⣉⣴⣿⣿⡇⠀⠀⠀
#⠀⢠⣿⣿⣿⣿⡄⠈⠀⠀⠀⠀⠀⠀⠙⠛⠿⠛⠋⣁⣴⣾⣿⣿⣿⣿⣿⠀⠀⠀
#⠀⠀⠀⣤⣤⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⢤⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡿⠀⠀⠀
#⠀⠀⠸⠿⠛⠛⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠹⢿⣿⣿⣿⣿⣿⣿⣿⡿⠃⠀⠀⠀
#⠀⠀⠀⠀⣾⡿⠂⠀⠀⠀⠀⠀⠀⠀⠸⣶⣶⣤⣤⣤⣤⣤⣤⣤⣤⣤⣴⣶⣾⠀
#⠀⠀⠀⠀⠈⠀⠚⠛⠒⠀⠀⠀⠀⠀⠀⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀
#⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠀⠀
#⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⢿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠀⠀⠀
#⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠛⠛⠿⠿⠛⠋⠁⠀⠀⠀⠀
# Description : Play Tic Tac Toe in Powershell
#


Class TTT{
    $player1 = 1
    $player2 = 2
    [Array] $board = 0,0,0,0,0,0,0,0,0
    $currentplayer = 1
    [Boolean] $playing = $true;

    [String] DrawPlayer($i){
        if ($i -eq 1){
            return("X")
        }
        if ($i -eq 2){
            return("O")
        }
        else{
            return("-")
        }
    }
    Reset(){
        $this.board = 0,0,0,0,0,0,0,0,0
        $this.currentplayer = 1
        $this.playing = $true
    }

    AddToBoard($index){
        if ($this.board[$index] -eq 0){
            $this.board[$index] = $this.currentplayer
            $this.ChangePlayer()
        }
        else{
            write-host "Position $index already in use."
        }
    }
    DrawBoard(){
        Clear-Host    
        Write-Host
        Write-Host "Tic Tac Toe"
        Write-Host "Current player is" $this.currentplayer
        Write-Host
        $i = 0
        foreach ($item in $this.board) {
            if ($i -lt 2){
                Write-Host $this.DrawPlayer($item) -ForegroundColor Yellow -NoNewline
                $i++     
            }
            else{
                Write-Host $this.DrawPlayer($item) -ForegroundColor Yellow
                $i = 0
            }
        }
    }
    [Boolean] CheckTie(){
        if ($this.board.Contains(0)){
            return $true
        }
        Write-Host
        Write-Host "It's a Tie" -ForegroundColor Yellow
        $this.playing = $false
        return $false
    }
    [Boolean] CheckWinner(){
    
        #Horizontal Check -
        for ($i = 0; $i -lt 9; $i = $i + 3){
            if ($this.board[$i + 0] -eq $this.currentplayer -and $this.board[$i + 1] -eq $this.currentplayer -and $this.board[$i + 2] -eq $this.currentplayer){
                    Write-Host
                    Write-Host "We have a winner! It's player" $this.currentplayer -ForegroundColor Green
                    $this.playing = $false
                    return $true
            }
        }

        #Vertical Check |
        for ($i = 0; $i -lt 3; $i++){
            if ($this.board[$i] -eq $this.currentplayer -and $this.board[$i + 3] -eq $this.currentplayer -and $this.board[$i + 6] -eq $this.currentplayer){
                    Write-Host
                    Write-Host "We have a winner! It's player" $this.currentplayer -ForegroundColor Green
                    $this.playing = $false
                    return $true
            }
        }

        #Diagonal Check Backward \
        if ($this.board[0] -eq $this.currentplayer -and $this.board[4] -eq $this.currentplayer -and $this.board[8] -eq $this.currentplayer){
            Write-Host
            Write-Host "We have a winner! It's player" $this.currentplayer -ForegroundColor Green
            $this.playing = $false
            return $true
        }

        #Diagonal Check Forward /
        if ($this.board[2] -eq $this.currentplayer -and $this.board[4] -eq $this.currentplayer -and $this.board[6] -eq $this.currentplayer){
            Write-Host
            Write-Host "We have a winner! It's player" $this.currentplayer -ForegroundColor Green
            $this.playing = $false
            return $true
        }
        return $false

    }
    ChangePlayer(){
        if ($this.currentplayer -eq 1){
            $this.currentplayer = 2
        }
        else{
            $this.currentplayer = 1
        }
    }
}

#Instantiate TicTacToe Object
$t = New-Object TTT
$t.DrawBoard()

#Play game until a winner, looser or tie.
while ($t.playing){

    $t.CheckWinner()
    $t.CheckTie()  


    $position = Read-Host "Select"
    if ($position.Length -eq 1){
        [int]$intNum = [convert]::ToInt32($position)
        $t.AddToBoard($intNum)
    }
    
    $t.DrawBoard()
}