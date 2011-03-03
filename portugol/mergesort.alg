início

variável inteiro pilha[100000]
variável inteiro valores[10] <- {9, 7, 10, 4, 2, 3, 1, 8, 6, 5}
variável inteiro temporário[10]
variável inteiro i <- 0
variável inteiro tamanho_da_pilha <- 1

pilha[0] <- 0
pilha[1] <- 10

enquanto i < tamanho_da_pilha faz
    se pilha[i*2+1] - pilha[i*2] > 1 então
        variavel inteiro média <- (pilha[i*2] + pilha[i*2+1]) / 2

        se média - pilha[i*2] > 1 então
            pilha[tamanho_da_pilha*2] <- pilha[i*2]
            pilha[tamanho_da_pilha*2+1] <- média
            tamanho_da_pilha <- tamanho_da_pilha + 1
        fimSe

        se pilha[i*2+1] - média > 1 então
            pilha[tamanho_da_pilha*2] <- média
            pilha[tamanho_da_pilha*2+1] <- pilha[i*2+1]
            tamanho_da_pilha <- tamanho_da_pilha + 1
        fimSe
    fimSe

    i <- i + 1
fimEnquanto

para i de tamanho_da_pilha-1 até 0 passo -1
    variável inteiro média <- (pilha[i*2] + pilha[i*2+1])/2

    variável inteiro c <- pilha[i*2]
    variável inteiro j <- pilha[i*2]
    variável inteiro k <- média

    enquanto j < média e k < pilha[i*2+1] faz
        se valores[j] < valores[k] então
            temporário[c] <- valores[j]
            j <- j + 1
        senão
            temporário[c] <- valores[k]
            k <- k + 1
        fimSe
        c <- c + 1
    fimEnquanto
    
    enquanto j < média faz
        temporário[c] <- valores[j]
        c <- c + 1
        j <- j + 1
    fimEnquanto

    enquanto k < pilha[i*2+1] faz
        temporário[c] <- valores[k]
        c <- c + 1
        k <- k + 1
    fimEnquanto

    para j de pilha[i*2] até pilha[i*2+1]-1
        valores[j] <- temporário[j]
    próximo
próximo

para i de 0 até 9
    escrever valores[i], "\n"
próximo

fim
