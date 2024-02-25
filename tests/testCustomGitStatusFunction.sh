source ./tests/messages.sh

function oneTimeSetUp(){
    script="./gitReposEditor.sh"
}

function testCustomGitStatusFunction(){
    touch temp.txt
    
    responseUntracked="$($script)"
    responseUntrackedWithoutColors=$(echo "$responseUntracked" | sed 's/\x1B\[[0-9;]*[JKmsu]//g')
    assertContains "${responseUntrackedWithoutColors}" "${mapExpectedMessages[0]}"

    git add .
    responseTracked="$($script)"
    responseTrackedWithoutColors=$(echo "$responseTracked" | sed 's/\x1B\[[0-9;]*[JKmsu]//g')
    assertEquals "${responseTrackedWithoutColors}" "${mapExpectedMessages[3]}"

    git restore --staged temp.txt
    rm temp.txt
}

shift $#

source shunit2