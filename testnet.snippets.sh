PROJECT="/Users/frank/Documents/blockchain/rust/multiversx/crowdfunding-esdt"
WALLET_PEM="/Users/frank/multiversx-sdk/testwallets/latest/users/alice.pem"
DEPLOY_OUTFILE="./logs/testnet/testnet-deploy-outfile.interaction.json"
ARGUMENT_BIGUINT_TARGET=5000000000000000000
ARGUMENT_U64_DEADLINE=1685354253
ARGUMENT_STRING_TOKEN_IDENTIFIER=0x45474c44
OWNER_ADDRESS="erd1qyu5wthldzr8wx5c9ucg8kjagg0jfs53s8nr3zpz3hypefsdd8ssycr6te"


deploySC() {
    mxpy --verbose contract deploy --recall-nonce \
    --project ${PROJECT} \
    --pem ${WALLET_PEM} \
    --arguments ${ARGUMENT_BIGUINT_TARGET} ${ARGUMENT_U64_DEADLINE} ${ARGUMENT_STRING_TOKEN_IDENTIFIER} \
    --gas-limit=60000000 \
    --outfile ${DEPLOY_OUTFILE} \
    --send || return
}
# deploySC


CONTRACT_ADDRESS="erd1qqqqqqqqqqqqqpgqgcj22kntzasw86asxp5j8wsslug55gqld8ss3a2jdg"
OUTFILE="./logs/testnet/testnet-outfile.interaction.json"

statusEndpoint() {
    mxpy --verbose contract query ${CONTRACT_ADDRESS} \
        --function="status"
}
statusEndpoint


VALUE=1000000000000000000
fundEndpoint() {
    mxpy --verbose contract call ${CONTRACT_ADDRESS} --recall-nonce \
        --pem=${WALLET_PEM} \
        --gas-limit=6000000 \
        --function="fund" \
        --value ${VALUE} \
        --outfile ${OUTFILE} \
        --wait-result --send || return
}
# fundEndpoint


depositEndpoint() {
    mxpy --verbose contract query ${CONTRACT_ADDRESS} \
        --function="getDeposit" \
        --arguments ${OWNER_ADDRESS}
}
# depositEndpoint


deadlineEndpoint() {
    mxpy --verbose contract query ${CONTRACT_ADDRESS} \
        --function="getDeadline"
}
# deadlineEndpoint