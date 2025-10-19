package org.repoklin.appfront

interface Platform {
    val name: String
}

expect fun getPlatform(): Platform